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
    
def record_user_click(index,keyword,url):
    urls = lookup(index,keyword)
    if urls:
        for entry in urls:
            if entry[0] == url:
                entry[1] = entry[1] +1
