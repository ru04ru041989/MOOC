"""The LinkedList code from before is provided below."""

class Element(object):
    def __init__(self, value):
        self.value = value
        self.next = None
        
class LinkedList(object):
    def __init__(self, head=None):
        self.head = head
        
    def append(self, new_element):
        current = self.head
        if self.head:
            while current.next: # find the latest element(.next = None) in linkedlist
                current = current.next
            current.next = new_element # assign this new element for pointing to
        else:
            self.head = new_element
                
    def get_position(self, position):
        """Get an element from a particular position.
        Assume the first position is "1".
        Return "None" if position is not in the list."""
        current = self.head
        index = 1
        while index < position:
            if current:
                current = current.next
            else:
                break
            index += 1
        if current:
            return current
        else:
            return None
    
    def insert(self, new_element, position):
        """Insert a new node at the given position.
        Assume the first position is "1".
        Inserting at position 3 means between
        the 2nd and 3rd elements."""
        if position == 1:
            new_element.next = self.head
            self.head = new_element
        else:
            current = self.get_position(position -1)
            new_element.next = current.next
            current.next = new_element
    
    
    def delete(self, value):
        """Delete the first node with a given value."""
        # find the first position of the value
        pos = 1
        while self.get_position(pos).value != value:
            pos += 1
        
        if pos == 1:
            self.head = self.head.next
        else:
            current = self.get_position(pos-1)
            to_del = self.get_position(pos)
            current.next = to_del.next


if __name__ == '__main__':
    # Test cases
    # Set up some Elements
    e1 = Element(1)
    e2 = Element(2)
    e3 = Element(3)
    e4 = Element(4)

    # Start setting up a LinkedList
    ll = LinkedList(e1)
    ll.append(e2)
    ll.append(e3)