"""
File: proj3.py -- Dana, April 24, 2018
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

CHANCE = 0
MIN = 1

t_table = {}
t = {}
seen = []
f_line = []
g_walls = []

'''
return the probability of reaching state (before) to state(after) through
calculating steering error properties
'''
def probability(before, after):
    ((x1,y1),(u1,v1)) = before
    ((x2,y2),(u2,v2)) = after
    prob = 1
    #calculate probability of reaching this state with chosen velocity
    if abs(u1) > 1 and abs(u2) > 1:
        if x1 == x2 and y1 == y2:
            prob = (3/5) * (3/5)
        elif (x1 == x2 and y1 != y2 ) or (x1 != x2 and y1 == y2):
            prob = (3/5) * (2/5)
        else: #x1 != x2 and y1 != y2
            prob = (2/5)
    elif abs(u1) > 1 and abs(u2) <= 1:
        if x1 == x2 and y1 == y2:
            prob = (3/5) 
        elif (x1 == x2 and y1 != y2 ):
            prob = 0
        elif (x1 != x2 and y1 == y2):
            prob = (2/5)
        else: #x1 != x2 and y1 != y2
            prob = 0
    elif abs(u1) <= 1 and abs(u2) > 1:
        if x1 == x2 and y1 == y2:
            prob = (3/5) 
        elif (x1 == x2 and y1 != y2 ):
            prob = (2/5)
        elif (x1 != x2 and y1 == y2):
            prob = 0
        else: #x1 != x2 and y1 != y2
            prob = 0
    elif abs(u1) < 1 and abs(u2) < 1:
        if x1 == x2 and y1 == y2:
            prob = 1
        else:
            prob = 0
    return prob

'''
return the possible states that can be attained through steering error
'''
def possible_state_with_error(state):
    ((x1,y1),(u1,v1)) = state
    return [((x1+1, y1), (u1,v1)), ((x1-1, y1), (u1,v1)), ((x1, y1+1), (u1,v1)), ((x1, y1-1), (u1,v1)), 
                                        ((x1+1, y1+1), (u1,v1)), ((x1-1, y1-1), (u1,v1))]
'''
creates tree of all possible states with min nodes and chance nodes.
Min nodes select the minimum chance node score
'''

def ExpectiMin(state, depth, player):
    global f_line, g_walls, t_table
    #If state is at goal, return 0
    if racetrack.goal_test(state,f_line):
        t_table[state] = 0 
        return 0
    #if there no new states to be made, return the heurisitc value
    if racetrack.next_states(state, g_walls) is None: # we are at a terminal node
        score = heuristics.h_walldist(state, f_line, g_walls)
        t_table[state] = score
        return score
    #if depth is 0, we are at leaf node and want to return the heurisitc value of that state
    elif depth == 0:
        score = (heuristics.h_walldist(state, f_line, g_walls))
        #print('LEAF:', score, state)
        t_table[state] = score
        return score
    elif player == MIN: #it's min's turn, we want to select the chance node child with minimum score
        score = math.inf
        for child in racetrack.next_states(state, g_walls):
            score = min(score, ExpectiMin(child,depth - 1, CHANCE))
        t_table[state] = score
        return score
    #if it's chance turn we want to take the sum of probability reaching a child * recursive call of algorithm
    elif player == CHANCE:
        score = 0
        ((x1,y1),(u1,v1)) = state
        possible_error_states = possible_state_with_error(state)
        for child in possible_error_states:
            score += probability(state, child) * ExpectiMin(child, depth - 1, MIN)
        #print(score)
        if score == 0:
            t_table[state] = math.inf
            return math.inf
        else:
            t_table[state] = math.inf
            return score

    

# Your proj3 function
def main(state,finish,walls):
    global f_line, g_walls, Q,t, seen, t_table
    f_line = finish
    g_walls = walls
    ((x,y), (u,v)) = state

    #initial = Node(2, False, state, heuristics.h_walldist(state, f_line, g_walls))
    
    ExpectiMin(state, 3, MIN)
    score = math.inf
    min_state = state
    for child in racetrack.next_states(state, g_walls):
        print(child, t_table[child])
        if t_table[child] <= score:
            score = t_table[child]
            min_state = child


    new_velocity = min_state[1]

    print('----------------------')
    print(new_velocity)
    f = open('choices.txt', 'w')
    path = racetrack.main(state,finish,walls,'gbf', heuristics.h_walldist, verbose=0, draw=0)
    #print("current state: {} and we are selecting velocity: {}".format(state, new_velocity))
    print("velcoity choice: {}".format(new_velocity))
    print("writing to file")
    print(new_velocity,file=f,flush=True)

def initialize(state,fline,walls):
    print('Unfortunately, this work will be lost when the process exits.')
    heuristics.edist_grid(fline,walls)

def edist_to_line(point, edge):
    """dw
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
