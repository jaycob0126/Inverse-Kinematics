class SegmentSys {

  int size;
  float len;
  PVector targ;
  PVector pinAt;

  Segment sEnd;
  Segment[] seg;
  Segment prev;

  float diameter = 2;

  SegmentSys(int s, float l) {

    size = s;
    len = l;
    //set the end segment
    sEnd = new Segment(width/2, height/2, len, radians(0));
    sEnd.vDia = diameter;

    prev = sEnd;
    //initialize all segments
    seg = new Segment[size - 1];
    for (int i=0; i < seg.length; i++) {
      seg[i] = new Segment(prev, len, radians(0));
      seg[i].vDia = diameter;
      prev = seg[i];
    }

    targ = new PVector();
    pinAt = new PVector();
  }

  void display() {
    //displays the end segment on the screen
    sEnd.show();
    sEnd.target(targ.x, targ.y);

    updateSegments(sEnd);
  }

  void target(float x, float y) {
    targ.set(x, y);
  }

  //updates every other segments, argument will be the end segment
  void updateSegments(Segment sgmt) {
    prev = sgmt;
    //shows other segments
    for (int i=0; i < seg.length; i++) {
      seg[i].show();

      //sets the vertex B to target vertex A of previous segment
      seg[i].target(prev.posA.x, prev.posA.y);
      prev = seg[i];
    }
  }

  //sets where to pin the root segment
  void pinned(float x, float y) {
    /**
     * pins the root segment's vertex A
     * and draws the other segment upto end
     *
     */

    //pinpoint of root segment
    PVector pinPoint = new PVector(x, y);

    //updates the root segment followed by others
    for (int i=seg.length -1; i > 0; i--) {
      seg[i].pinnedAt(pinPoint.x, pinPoint.y);
      seg[i].target(seg[i-1].posA.x, seg[i-1].posA.y);

      pinPoint.x = seg[i].posB.x;
      pinPoint.y = seg[i].posB.y;
    }

    if (size > 1) {
      seg[0].pinnedAt(pinPoint.x, pinPoint.y);
      seg[0].target(sEnd.posA.x, sEnd.posA.y);
      sEnd.pinnedAt(seg[0].posB.x, seg[0].posB.y);
      sEnd.target(targ.x, targ.y);
    }else {
      sEnd.pinnedAt(x, y);
      sEnd.target(targ.x, targ.y);
    }
  }

  Segment segNum(int i) {
    if (i == 0) {
      return sEnd;
    } else {
      return seg[i-1];
    }
  }
}
