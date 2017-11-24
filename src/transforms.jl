"""
    Convert 3D point to 2D using a perspective projection.
"""
function project(pt3D::Point3D, proj::Projection)
    # distance from eye to center
    Ez = norm(proj.eyepoint, Point3D(0, 0, 0))
	x = (proj.eyepoint.z * (pt3D.x - proj.eyepoint.x)) / (proj.eyepoint.z + pt3D.z) + proj.eyepoint.x
	y = (proj.eyepoint.z * (pt3D.y - proj.eyepoint.y)) / (proj.eyepoint.z + pt3D.z) + proj.eyepoint.y
    return Point(x, y)
end

function modeltopoly(m::Model, proj::Projection)
    vertices2D = Point[]
    for v in m.vertices
        push!(vertices2D, project(v, proj))
    end
    facepolys = []
    if length(m.faces) > 0
        for f in m.faces
            push!(facepolys, vertices2D[f])
        end
    end
    return (vertices2D, facepolys)
end

# rotations are anticlockwise when looking along axis from 0 to +axis
"""
    rotate around x axis
"""
function rotateX(pt3D, rad)
    cosa = cos(rad)
    sina = sin(rad)
    y = pt3D.y * cosa - pt3D.z * sina
    z = pt3D.y * sina + pt3D.z * cosa
    return Point3D(pt3D.x, y, z)
end

"""
    rotate around y axis
"""
function rotateY(pt3D, rad)
    cosa = cos(rad)
    sina = sin(rad)
    z = pt3D.z * cosa - pt3D.x * sina
    x = pt3D.z * sina + pt3D.x * cosa
    return Point3D(x, pt3D.y, z)
end

"""
rotate around z axis to an angle
"""
function rotateZ(pt3D, rad)
    cosa = cos(rad)
    sina = sin(rad)
    x = pt3D.x * cosa - pt3D.y * sina
    y = pt3D.x * sina + pt3D.y * cosa
    return Point3D(x, y, pt3D.z)
end

# rotate model to an angle
function rotateto!(m::Model, angleX, angleY, angleZ)
    for n in 1:length(m.vertices)
        v = m.vertices[n]
        v = rotateX(v, angleX)
        v = rotateY(v, angleY)
        v = rotateZ(v, angleZ)
        m.vertices[n] = v
    end
    return m
end

# make a rotated copy
function rotateto(m::Model, angleX, angleY, angleZ)
    mcopy = deepcopy(m)
    return rotateto!(mcopy, angleX, angleY, angleZ)
end

function move!(m::Model, x, y, z)
    for n in 1:length(m.vertices)
        nv = m.vertices[n]
        m.vertices[n] = Point3D(nv.x + x, nv.y + y, nv.z + z)
    end
    return m
end

"""
    changescale!(m::Model, x, y, z)

"""
function changescale!(m::Model, x, y, z)
    for n in 1:length(m.vertices)
        nv = m.vertices[n]
        m.vertices[n] = Point3D(nv.x * x, nv.y * y, nv.z * z)
    end
    return m
end
