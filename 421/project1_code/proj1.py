'''
I pledge on my honor that I have not given or received

any unauthorized assistance on this project.

Robert Choe

'''
import racetrack,math, heuristics
import sys
from collections import defaultdict

infinity = float('inf')  
g_fline = False
g_walls = False
grid = []
corners = set()
s_corners = []
target_corner = None
stack = []

def corn(walls,fline):

    '''
    This function will cacluate points near all corners of the maps and estimate it's distance to 
    the finish line. 
    '''
    global corners, s_corners, xmax, ymax, target_corner, stack 
    xmax = max([max(x,x1) for ((x,y),(x1,y1)) in walls])
    ymax = max([max(y,y1) for ((x,y),(x1,y1)) in walls])

    #adding all corners to a corners list
    for wall in walls:
        corners.add(wall[0])
        corners.add(wall[1])
    #add points to the left,right,up, and down of each corner point to s_corners list
    for c in corners:
        if not racetrack.crash([(c[0] +1,c[1]),(c[0] +1,c[1])], walls) and c[0]+1 > 0 and c[0] +1 < xmax and c[1] > 0 and c[1] <ymax:
            s_corners.append((c[0]+1, c[1]))        #right
        if not racetrack.crash([(c[0] -1,c[1]),(c[0]-1, c[1])], walls) and c[0]-1 > 0 and c[0] -1 < xmax and c[1] > 0 and c[1] <ymax:
            s_corners.append((c[0]-1, c[1]))        #left
        if not racetrack.crash([(c[0],c[1]+1),(c[0], c[1]+1)], walls) and c[0] > 0 and c[0] < xmax and c[1] +1 > 0 and c[1]+1 <ymax:
            s_corners.append((c[0], c[1]+1))        #up
        if not racetrack.crash([(c[0],c[1]-1),(c[0], c[1]-1)], walls) and c[0] > 0 and c[0] < xmax and c[1] -1 > 0 and c[1]-1 <ymax:
            s_corners.append((c[0], c[1]-1))        #down 
    #Find closest point in s_corners that has straight line path to finish line
    for corner in s_corners:
        dist = heuristics.edistw_to_finish(corner, fline, walls)
        if dist != infinity:
            if not target_corner:
                target_corner = (corner, dist)
            elif dist < target_corner[1]:
                target_corner = (corner, dist)

    stack.append(target_corner)
    if target_corner:
        s_corners.remove(target_corner[0])
    max_limit = len(s_corners) * len(s_corners)
    i = 0

    #Working backwards from closest point in s_corners, estimates all points distance to finish line
    
    if s_corners:
        while i < max_limit:
            min_dist = infinity
            min_corner = None
            for corner in s_corners:
                temp = None
                dist = heuristics.edistw_to_finish(corner, [stack[0][0], stack[0][0]], walls)
                if dist != infinity and dist != 0:
                    if dist < min_dist:
                        min_dist = dist
                        min_corner = corner
            if min_corner:
                stack.insert(0, (min_corner, min_dist + stack[0][1]))
                s_corners.remove(min_corner)
                    
            i += 1




def h_proj1(state, fline, walls):
    '''
    The first time this function is called, for points near all corners in the map it will 
    cacluate its distance to the finish line. It does this by seeing what the nearest corner point
    that can reach the finish line with a euclidean distance without crashing and stores that distance 
    in a stack. It will then find the closest corner point that can reach the point at the top of the 
    stack and add it's euclidean distance to that point + the distance fromt that point to the finish line.
    By then end most/all of points near corner will have an estimate of it's distance to the finish line.

    At each state, the heurisitc will find the nearest corner point it can go to, and add it's
    euclidean distance to it + the points distance to the finish line. 
    '''
    global s_corners, xmax, ymax,stack
    corner = None
    if not corners:
        print("filling in corners -------------------------------------------")
        corn(walls, fline)

    ((x,y),(u,v)) = state
    ((x1,y1),(x2,y2)) = fline

    
    '''
    If the state has a straight line distance to to the finish line without any walls between,
    use the euclidean heuristic provided
    '''

    if heuristics.edistw_to_finish((x,y), fline, walls) != infinity:
        return heuristics.h_esdist(state, fline, walls)
   
    else:
        mininum = math.inf
        for i, c in enumerate(stack):
            distance_to_corner = heuristics.edistw_to_finish((x, y), [(c[0][0],c[0][1]),(c[0][0],c[0][1])], walls)
            corner_to_fline = c[1]
            d = distance_to_corner + corner_to_fline
            if d <= mininum:
                corner = c
                mininum = d
                index = i
        # add a small penalty to favor short stopping distances
        au = abs(u); av = abs(v); 
        sdu = au*(au-1)/2.0
        sdv = av*(av-1)/2.0
        sd = max(sdu,sdv)
        penalty = sd/10.0
    
        # compute location after fastest stop, and add a penalty if it goes through a wall
        if u < 0: sdu = -sdu
        if v < 0: sdv = -sdv
        sx = x + sdu
        sy = y + sdv
        if racetrack.crash([(x,y),(sx,sy)],walls):
            penalty += math.sqrt(au**2 + av**2)
        hval = max(mininum+penalty,sd)

        return hval
        