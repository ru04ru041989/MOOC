# crawl web

def get_page(url):
    try:
        import urllib
        return urllib.request.urlopen(url).read()
    except:
        return ""

def get_next_target(page):
    start_link = page.find('<a href=')
    if start_link == -1: 
        return None, 0
    start_quote = page.find('"', start_link)
    end_quote = page.find('"', start_quote + 1)
    url = page[start_quote + 1:end_quote]
    return url, end_quote # return the url and the pos of the url in the given page

def get_all_links(page): # getting all the url in the given page
    links = []
    while True:
        url,endpos = get_next_target(page)
        if url:
            links.append(url)
            page = page[endpos:]
        else:
            break
    return links

def union(p,q): # merge 2 list except the same item
    for e in q:
        if e not in p:
            p.append(e)
            
def add_to_index(index, keyword, url):
    ''' index as a dictionary'''
    
    if keyword in index: # look if keyword exist
        index[keyword].append(url) # if yes, add url
    else:
        index[keyword] = [url] # if no, add new keyword to index and url
        
    
def add_page_to_index(index, url, content): # pair the url to all the words in the webpage
    words = content.split() # split the str in the page into words
    for word in words: 
        add_to_index(index, word, url)
            # for all the word in this page, pair with the url(which has this word)
            
def lookup(index, keyword):
    '''look into index, find the given keyword, return the urls'''
    if keyword in index:
        return index[keyword]
    else:
        return None
        

def crawl_web(seed):
    tocrawl = [seed]   # seed: given url, tocrawl:prepare the url for crawing
    crawled = [] # store the url which is crawed
    index = {} # add the url, content of the page in to index, index as a dictionary
    graph = {} # # <url>:[list of pages it links to]
    
    # start crawling 
    while tocrawl:               # repeate till no url in tocrawl
        page = tocrawl.pop()     # using pop() to extract last url in tocrawl into page
        
        if page not in crawled:  # if the url(in page) not in crawled [not crawl yet]
            content = get_page(page) # extract the content for current url
            outlinks = get_all_links(content) # list of the links in given content
            
            add_page_to_index(index,page,content) # update index
            graph[page] = outlinks            
            
            union(tocrawl, outlinks) # update tocrawl with url in current page
                # crawing the page using get_all_links() and add the new links to tocrawl
            crawled.append(page)
                # after crawing, add the crawed url(page) to crawled
    
    return index, graph  # return the final structure for lookup to search


def is_reciprocal_link(graph, source, destination, k):
    ''' helper function for compute_ranks'''
    
    if k == 0: # k = 0, only when page self-link
        if destination == source:
            return True
        return False
    
    if source in graph[destination]: # k = 1, when page shows up in their link's link
        return True
    for node in graph[destination]: # go deeper with updating node and k
        if is_reciprocal_link(graph, source, node, k-1):
            return True
    return False


def compute_ranks(graph, k):
    '''rank(page, 0) = 1/npages
       rank(page, t) = (1-d)/npages 
               + sum (d * rank(p, t - 1) / number of outlinks from p) 
          over all pages p that link to this page 
       k: The length of a link path is the number of links which are 
       taken to travel from one page to the other'''
          
    d = 0.8 # damping factor
    numloops = 10 # steps in 10 times
    
    ranks = {} # set up ranks as and dictionary
    npages = len(graph)
    for page in graph: # loop over each page which storage in graph
        ranks[page] = 1.0 / npages # intial value for each page
    
    for i in range(0, numloops): # compute ranks base on links for each steps
        newranks = {}
        for page in graph: # compute and update ranks according to the equation, for each page
            newrank = (1 - d) / npages
            for node in graph:
                if page in graph[node]:
                    if not is_reciprocal_link(graph, node, page, k):
                        newrank = newrank + d * ranks[node] / len(graph[node])

            newranks[page] = newrank
        ranks = newranks
    return ranks



def record_user_click(index,keyword,url):
    urls = lookup(index,keyword)
    if urls:
        for entry in urls:
            if entry[0] == url:
                entry[1] = entry[1] +1


def lucky_search(index, ranks, keyword, isMax):
    '''takes as input an index, a ranks dictionary (the result of compute_ranks)
       returns the one URL most likely to be the best site for that keyword
       If the keyword does not appear in the index, return None'''
       
    if lookup(index,keyword) == None: # check if keyword appear in the index
        return None
    # creat a new dictionary ls, to store url and ranks 
    ls = {} 
    for i in lookup(index,keyword):
        ls[i] = ranks[i]
        
    # use build-in function to get and return max value in ls
    if isMax:
        return max(ls, key=ls.get)
    
    # return a list with ranked url
    return sorted(ls, key=ls.__getitem__, reverse=True) 

