"""
File: proj2.py -- Dana, April 24, 2018
I pledge on my honor that I have not given or received
any unauthorized assistance on this project.
Robert Choe
"""

import time
import heuristics
import racetrack   # program that runs fsearch
import math
import random
import supervisor
Q = {}
t = {}
seen = []
fline = []
g_walls = []
'''
state -> current state
return -> list of velocities [(u1,v1), (u2,v2)...]
function that returns the possible new velocities at state(s)
'''
def applicable(state):
    '''
    velocities = []
    ((x,y),(vx,vy)) = state
    for dx in [0,-1,1]:
        for dy in [0,-1,1]:
            (wx,wy) = (vx+dx,vy+dy)
            newloc = (x+wx,y+wy)
            if not racetrack.crash(((x,y),newloc),g_walls):
                velocities.append((wx,wy))
    return velocities
    '''
    next_states = racetrack.next_states(state, g_walls)
    velocities = list(map(lambda x: x[1], next_states))
    return velocities

#Implementation of UCT provided by project2 pdf 
def UCT(s,depth):
    global fline, g_walls, Q,t,seen
    if racetrack.goal_test(s, fline):
        return -50
    if depth == 0:
        return heuristics.h_walldist(s, fline, g_walls)

    # if there are no applicable velocities at this state then that means we are going to crash
    if not applicable(s):
        return 200
    if not s in seen:
        seen.append(s)
        t[s] = 0
        for z in applicable(s):
            Q[(s, z)] = 0 
            t[(s, z)] = 0 

    untried = list(filter(lambda x: t[(s, x)] == 0 , applicable(s)))
    z_prime = None    
    if untried: 
        z_prime = random.choice(untried)
    else:
        #after experminentation, choosing 6 for the value of k seems to converge better
        x = list(map(lambda x: Q[(s, x)] -  6 * math.sqrt(math.log(t[s]) / t[(s, x)]) , applicable(s)))
        min_index, min_val = 0, x[0]
        for i, y in enumerate(x):
            if y < min_val:
                min_index, min_val = i, y
        z_prime = applicable(s)[min_index]
    
    (loc,(vx,vy)) = s
    
    #(wx,wy) = (z_prime[0]+vx , z_prime[1]+vy)
    
    error = supervisor.steering_error(z_prime[0], z_prime[1])
    
    new_state = ((loc[0]+ z_prime[0] + error[0] , loc[1]+ z_prime[1] + error[1]), z_prime)

    if racetrack.crash((loc,new_state[0]),g_walls):
        cost = 50 #a penalty
    else:
        cost = 1 + UCT(new_state,depth - 1)
    Q[(s, z_prime)] = (t[(s, z_prime)] * Q[(s, z_prime)] + cost) / (1 + t[(s, z_prime)])
    t[s] = t[s] + 1
    t[(s, z_prime)] =  t[(s, z_prime)] + 1
    return cost


# Your proj2 function
def main(state,finish,walls):
    global fline, g_walls, Q,t, seen
    fline = finish
    g_walls = walls
    ((x,y), (u,v)) = state
    f = open('choices.txt', 'w')
    path = racetrack.main(state,finish,walls,'gbf', heuristics.h_walldist, verbose=0, draw=0)

    '''
    Depth varies depending on how far the current state is from the finish line
    The closer it is, the smaller depth is used
    '''
    if heuristics.h_walldist(state, finish, walls) > 5:
        for i in range(50):
            UCT(state, 3)
    else:
        for i in range(50):
            UCT(state, 1) 

    #At this current state, get the average cost of using different velocities at this state
    curr_state = []
    for key, cost  in Q.items():
        if key[0] == state:
            curr_state.append((key[1], cost))
    
    ''''
    for i in curr_state:
        print("average cost of using velcoity {} at this state {} is: {} ".format(i[0], state, i[1]))   
    '''

    #Choose the velocity with the minimum average cost of using it at this state
    new_velocity = min(curr_state, key = lambda t: t[1])

    #print("current state: {} and we are selecting velocity: {}".format(state, new_velocity))
    print("velcoity choice: {}".format(new_velocity[0]))
    print("writing to file")
    print(new_velocity[0],file=f,flush=True)

def initialize(state,fline,walls):
    print('Unfortunately, this work will be lost when the process exits.')
    heuristics.edist_grid(fline,walls)

def edist_to_line(point, edge):
    """
    Euclidean distance from (x,y) to the line ((x1,y1),(x2,y2)).
    """
    (x,y) = point
    ((x1,y1),(x2,y2)) = edge
    if x1 == x2:
        ds = [math.sqrt((x1-x)**2 + (y3-y)**2) \
            for y3 in range(min(y1,y2),max(y1,y2)+1)]
    else:
        ds = [math.sqrt((x3-x)**2 + (y1-y)**2) \
            for x3 in range(min(x1,x2),max(x1,x2)+1)]
    return min(ds)
