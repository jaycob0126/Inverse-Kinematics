/**
*This is an inverse Kinematics code
*that follows the mouse pointer
*/

SegmentSys s1;
SegmentSys s2;

void setup() {
  size(500, 500);
  
  s1 = new SegmentSys(10, 50);
  s2 = new SegmentSys(10, 50);
}

void draw() {
  background(255);
  s1.display();
  s1.target(mouseX, mouseY);
  s1.pinned(width/2-100, height);
  
  s2.display();
  s2.target(mouseX, mouseY);
  s2.pinned(width/2 + 100, height);
  
}
