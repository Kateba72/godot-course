extends Node

# Given three colinear points p, q, r, the function checks if 
# point q lies on line segment 'pr' 
func on_segment(p : Vector2, q  : Vector2, r : Vector2) -> bool:
    if q.x <= max(p.x, r.x) and q.x >= min(p.x, r.x) and q.y <= max(p.y, r.y) and q.y >= min(p.y, r.y) :
       return true; 
    return false; 
  
# To find orientation of ordered triplet (p, q, r). 
# The function returns following values 
# 0 --> p, q and r are colinear 
# 1 --> Clockwise 
# 2 --> Counterclockwise 
func orientation(p : Vector2, q  : Vector2, r : Vector2) -> int:
    # See https://www.geeksforgeeks.org/orientation-3-ordered-points/ 
    # for details of below formula. 
	var val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)  
	if val == 0: return 0;  #// colinear 
	if val > 0: return 1
	else: return 2  #// clock or counterclock wise 
  
# The main function that returns true if line segment 'p1q1' 
# and 'p2q2' intersect. 
func do_intersect(p1 : Vector2, q1 : Vector2, p2 : Vector2, q2 : Vector2) -> bool:

    #// Find the four orientations needed for general and 
    #// special cases 
    var o1 = orientation(p1, q1, p2) 
    var o2 = orientation(p1, q1, q2) 
    var o3 = orientation(p2, q2, p1) 
    var o4 = orientation(p2, q2, q1) 
  
    #// General case 
    if o1 != o2 and o3 != o4:
        return true; 
  
    #Special Cases 
    # p1, q1 and p2 are colinear and p2 lies on segment p1q1 
    if o1 == 0 && on_segment(p1, p2, q1): return true; 
  
    #p1, q1 and q2 are colinear and q2 lies on segment p1q1 
    if o2 == 0 && on_segment(p1, q2, q1): return true; 
  
    #p2, q2 and p1 are colinear and p1 lies on segment p2q2 
    if (o3 == 0 && on_segment(p2, p1, q2)): return true; 
  
    # p2, q2 and q1 are colinear and q1 lies on segment p2q2 
    if (o4 == 0 && on_segment(p2, q1, q2)): return true; 
  
    return false; # Doesn't fall in any of the above cases 


func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with("."):
            files.append(file)

    dir.list_dir_end()

    return files