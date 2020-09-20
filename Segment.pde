class Segment {

  PVector posA;
  PVector posB;
  float len;
  float myAngle;
  float angle;
  boolean pinned = false;
  float vDia;

  Segment(float x, float y, float l, float a) {

    posA = new PVector(x, y);
    len = l;
    myAngle = a;

    posB = posA.copy();
    posB.add(len * cos(myAngle), -len * sin(myAngle));
  }

  Segment(Segment s, float l, float a) {

    posB = s.posA.copy();

    myAngle = a;
    angle = myAngle + s.myAngle;
    len = l;

    posA = posB.copy();
    posA.add(-len * cos(angle), len * sin(angle));
  }

  void show() {
    strokeWeight(1);
    stroke(0);
    line(posA.x, posA.y, posB.x, posB.y);
    fill(0);
    ellipse(posA.x, posA.y, vDia, vDia);
  }

  void pinnedAt(float x, float y) {
    pinned = true;
    posA.set(x, y);
  }

  void target(float x, float y) {
    if (pinned) {
      PVector target = new PVector(x, y);
      PVector dir = PVector.sub(target, posA);
      dir.normalize();
      dir.mult(len);
      posB = PVector.add(posA, dir);
      
      //unpins the segment for the next frame
      pinned = false;
    } else {
      posB.set(x, y);
      PVector dir = PVector.sub(posA, posB);
      dir.normalize();
      dir.mult(len);
      posA = PVector.add(posB, dir);
    }
  }
}
