# A circular queue is a collection of objects stored in a buffer that is treated
# as though it is connected end-to-end in a circle. When an object is added to
# this circular queue, it is added to the position that immediately follows the
# most recently added object, while removing an object always removes the object
# that has been in the queue the longest.

# This works as long as there are empty spots in the buffer. If the buffer
# becomes full, adding a new object to the queue requires getting rid of an
# existing object; with a circular queue, the object that has been in the queue
# the longest is discarded and replaced by the new object.

# Assuming we have a circular queue with room for 3 objects, the circular queue
# looks and acts like this:
