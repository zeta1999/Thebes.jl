"""
    make(primitive)

Eg

    make(Cube)

"""
function make(vf)
    # don't redefine constants when passed an array :)
    vertices = deepcopy(vf[1])
    faces    = deepcopy(vf[2])
    labels   = collect(1:length(faces))
    return Model(vertices, faces, labels)
end

const Cube = (
   [
    Point3D(-0.5,  0.5, -0.5),
    Point3D(0.5,   0.5, -0.5),
    Point3D(0.5,  -0.5, -0.5),
    Point3D(-0.5, -0.5, -0.5),
    Point3D(-0.5,  0.5,  0.5),
    Point3D(0.5,   0.5,  0.5),
    Point3D(0.5,  -0.5,  0.5),
    Point3D(-0.5, -0.5,  0.5)
    ],
   [[1, 2, 3, 4],
    [2, 6, 7, 3],
    [6, 5, 8, 7],
    [5, 1, 4, 8],
    [1, 5, 6, 2],
    [4, 3, 7, 8]])

const Tetrahedron = (
    [
    Point3D(1, 1, 1),
    Point3D(-1, -1, 1),
    Point3D(-1, 1, -1),
    Point3D(1, -1, -1)
    ],
   [[1, 2, 3],
    [1, 2, 4],
    [2, 3, 4],
    [4, 1, 3]])

const Pyramid = ([
    Point3D(-1, -1, 0),
    Point3D(1, -1, 0),
    Point3D(1, 1, 0),
    Point3D(-1, 1, 0),
    Point3D(0, 0, 1)],
   [[1, 2, 3, 4],
    [1, 2, 5],
    [2, 3, 5],
    [3, 4, 5],
    [4, 1, 5]])

const AxesWire = (
    [
Point3D(0.0, 0.0, 0.0),
Point3D(10.0, 0.0, 0.0),
Point3D(0.0, 0.0, 0.0),
Point3D(0.0, 10.0, 0.0),
Point3D(0.0, 0.0, 0.0),
Point3D(0.0, 0.0, 10.0),
Point3D(0.0, 0.0, 0.0)
    ], [])

const Carpet = (
[
Point3D(-10.0, -10.0, 0.0),
Point3D(-10.0, 10.0, 0.0),
Point3D(10.0, 10.0, 0.0),
Point3D(10.0, -10.0, 0.0)
],
[
[1, 2, 3, 4]
])

const Octahedron = (
[
Point3D( 0.0,  0.0,  1.0),
Point3D( 1.0,  0.0,  0.0),
Point3D( 0.0,  1.0,  0.0),
Point3D(-1.0,  0.0,  0.0),
Point3D( 0.0, -1.0,  0.0),
Point3D( 0.0,  0.0, -1.0)
]
,
[[2, 1, 5],
 [5, 1, 4],
 [4, 1, 3],
 [3, 1, 2],
 [2, 6, 3],
 [3, 6, 4],
 [4, 6, 5],
 [5, 6, 2]]
)