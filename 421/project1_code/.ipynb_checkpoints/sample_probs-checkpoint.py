"""
Test problems for Project 1 -- Dana Nau, Sept. 13, 2018

Here's a list of all the test problems in this file,
given roughly in increasing order of difficulty:

[rect20a, rect20b, rect20c, rect20d, rect20e, rect50, wall8a, wall8b, \
    lhook16, rhook16a, rhook16b, spiral16, spiral24, pdes30, pdes30b, \
    rectwall8, rectwall16, rectwall32, rectwall32a]

Each test problem is a list of the form [p0, finish, walls], where
   p0 is the starting point;
   finish is the finish line;
   walls is a list of walls.

If you want to see what one of the problems (say, rect20a) looks like,
you can do it like this:

   import sample_probs, tdraw
   tdraw.draw_problem(sample_probs.rect20a, title='rect20a')

If you have a heuristic named h1 in a file named heuristics.py, and you
want GBF to use it on rect20a, you can do it like this:

   import racetrack, sample_probs, heuristics
   racetrack.main(sample_probs.rect20a, 'gbf', heuristics.h1, 1, 1, 'rect20a')
"""

# A small rectangular region, with no obstacles in the way. There are four
# different orientations of the starting point and finish line, so you can
# check whether you're handling your x and y coordinates consistently.

rect20a = [(5,12), [(15,5),(15,15)],
    [[(0,0),(20,0)], [(20,0),(20,20)], [(20,20),(0,20)], [(0,20),(0,0)]]]

rect20b = [(15,12), [(5,5),(5,15)],
    [[(0,0),(20,0)], [(20,0),(20,20)], [(20,20),(0,20)], [(0,20),(0,0)]]]

rect20c = [(12,5), [(5,15),(15,15)],
    [[(0,0),(20,0)], [(20,0),(20,20)], [(20,20),(0,20)], [(0,20),(0,0)]]]

rect20d = [(12,15), [(5,5),(15,5)],
    [[(0,0),(20,0)], [(20,0),(20,20)], [(20,20),(0,20)], [(0,20),(0,0)]]]

rect20e = [(12,15), [(1,5),(10,5)],
    [[(0,0),(20,0)], [(20,0),(20,20)], [(20,20),(0,20)], [(0,20),(0,0)]]]


# A larger rectangular region, with the starting point farther from the finish
# line. This is useful for testing whether you're overshooting.

rect50 = [(3,40), [(30,10),(30,30)],
    [[(0,0),(50,0)], [(50,0),(50,50)], [(50,50),(0,50)], [(0,50),(0,0)]]]

# the finish line is behind a wall

wall8a = [(2,1), [(4,5),(5,5)],
    [[(0,0),(8,0)], [(8,0),(8,8)], [(8,8),(0,8)], [(0,8),(0,0)], [(4,0),(4,5)]]]

wall8b = [(2,1), [(4,1),(5,1)],
    [[(0,0),(8,0)], [(8,0),(8,8)], [(8,8),(0,8)], [(0,8),(0,0)], [(4,0),(4,5)]]]


lhook16 = [(2,1), [(13,1),(14,1)],
    [[(0,0),(16,0)], [(16,0),(16,16)], [(16,16),(0,16)], [(0,16),(0,0)], [(9,0),(9,11)], [(9,11),(6,11)], [(6,11),(6,7)]]]

rhook16a = [(2,2), [(10,7),(11,7)],
    [[(0,0),(16,0)], [(16,0),(16,16)], [(16,16),(0,16)], [(0,16),(0,0)], [(4,0),(4,12)], [(4,12),(12,12)], [(12,12),(12,5)]]]

rhook16b = [(2,2), [(10,7),(11,7)],
    [[(0,0),(16,0)], [(16,0),(16,16)], [(16,16),(0,16)], [(0,16),(0,0)], [(4,0),(4,12)], [(4,12),(12,12)], [(12,12),(12,4)]]]

# a spiral-shaped wall

spiral16 = [(2,2), [(10,6),(11,6)],
    [[(0,0),(16,0)], [(16,0),(16,16)], [(16,16),(0,16)], [(0,16),(0,0)], [(4,0),(4,12)], [(4,12),(12,12)], [(12,12),(12,4)], [(12,4),(8,4)], [(8,4),(8,8)]]]

spiral24 = [(3,3), [(15,10),(17,10)],
    [[(0,0),(24,0)], [(24,0),(24,24)], [(24,24),(0,24)], [(0,24),(0,0)], [(6,0),(6,18)], [(6,18),(18,18)], [(18,18),(18,6)], [(18,6),(12,6)], [(12,6),(12,12)]]]

# the example in the project description, and a variant with the wall farther down

pdes30 = [(4,5), [(24,8),(26,8)],
    [[(0,0),(10,0)], [(10,0),(10,10)], [(10,10),(20,10)], [(20,10),(30,0)], [(30,0),(30,10)], [(30,10),(10,20)], [(10,20),(0,20)], [(0,20),(0,0)], [(3,14),(10,14)], [(10,14),(10,16)], [(10,16),(3,16)], [(3,16),(3,14)]]]

pdes30b = [(4,5), [(28,3),(29,3)],
    [[(0,0),(10,0)], [(10,0),(10,10)], [(10,10),(20,10)], [(20,10),(30,0)], [(30,0),(30,10)], [(30,10),(10,20)], [(10,20),(0,20)], [(0,20),(0,0)], [(3,14),(10,14)], [(10,14),(10,16)], [(10,16),(3,16)], [(3,16),(3,14)]]]

# the finish line is behind a wall that's connected to a rectangular obstacle

rectwall8 = [(3,1), [(5,1),(6,1)],
    [[(0,0),(8,0)], [(8,0),(8,8)], [(8,8),(0,8)], [(0,8),(0,0)], [(4,0),(4,2)], [(3,2),(5,2)], [(5,2),(5,6)], [(5,6),(3,6)], [(3,6),(3,2)]]]

rectwall16 = [(6,2), [(10,2),(12,2)],
    [[(0,0),(16,0)], [(16,0),(16,16)], [(16,16),(0,16)], [(0,16),(0,0)], [(8,0),(8,4)], [(6,4),(10,4)], [(10,4),(10,12)], [(10,12),(6,12)], [(6,12),(6,4)]]]

rectwall32 = [(12,4), [(20,4),(24,4)],
    [[(0,0),(32,0)], [(32,0),(32,32)], [(32,32),(0,32)], [(0,32),(0,0)], [(16,0),(16,8)], [(12,8),(20,8)], [(20,8),(20,24)], [(20,24),(12,24)], [(12,24),(12,8)]]]

rectwall32a = [(12,4), [(20,4),(24,4)],
    [[(0,0),(32,0)], [(32,0),(32,32)], [(32,32),(0,32)], [(0,32),(0,0)], [(16,0),(16,8)], [(12,8),(20,8)], [(20,8),(20,22)], [(20,22),(12,22)], [(12,22),(12,8)], [(16,32),(16,24)]]]
