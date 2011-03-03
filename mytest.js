q0 = mkTriangle()
q1 = mkTriangle()
q2 = mkTriangle()
q3 = mkTriangle()

q1.p0.x = 300
q2.p0.y = 300
q3.p0.x = 300
q3.p0.y = 300

Point.eq(q0.p1, q1.p1)
Point.eq(q0.p2, q2.p2)
Point.eq(q1.p3, q3.p3)
Point.eq(q1.p2, q3.p2)
Point.eq(q2.p1, q3.p1)

l0 = mkLine(); Point.eq(l0.p0, q0.p1); Point.eq(l0.p1, q0.p2)
l1 = mkLine(); Point.eq(l1.p0, q1.p1); Point.eq(l1.p1, q1.p2)
l2 = mkLine(); Point.eq(l2.p0, q2.p1); Point.eq(l2.p1, q2.p2)
l3 = mkLine(); Point.eq(l3.p0, q3.p1); Point.eq(l3.p1, q3.p2)

l4 = mkLine(); Point.eq(l4.p0, q0.center); Point.eq(l4.p1, q3.center)
l5 = mkLine(); Point.eq(l5.p0, q1.center); Point.eq(l5.p1, q2.center)

t0 = mkText("test")
t1 = mkText("test")
t2 = mkText("test")
t3 = mkText("test")
t4 = mkText("test")
t5 = mkText("test")

Point.eq(t0.p0, q2.center)
Point.eq(t0.p1, q1.center)
Point.eq(t1.p0, q0.center)
Point.eq(t1.p1, q3.center)
Point.eq(t2.p0, q1.p1)
Point.eq(t2.p1, q1.p2)
Point.eq(t3.p0, q2.p1)
Point.eq(t3.p1, q2.p2)
Point.eq(t4.p0, q0.p1)
Point.eq(t4.p1, q0.p2)
Point.eq(t5.p0, q3.p1)
Point.eq(t5.p1, q3.p2)

