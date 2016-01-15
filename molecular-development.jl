
using PyCall
@pyimport mayavi.mlab as mlab

pygui_start(:qt) # make mayavi non-blocking

mlab.figure(1, bgcolor=(1, 1, 1), fgcolor=(0, 0, 0), size=(1000, 800));

include("ndgrid_rak.jl")

x = linspace(-10.0,10.0,20)
y = linspace(-10.0,10.0,20)
z = linspace(-10.0,10.0,20)

X, Y, Z = ndgrid(x, y, z);
#S = sin(X.*Y.*Z)./(X.*Y.*Z);
S = sqrt(X.^2+2.0*Y.^2+0.5*Z.^2);

function f(x)
    if abs(x)>10.0 x=0.0 end
    return x
end

map!((x) -> f(x) , S);

mlab.clf()
isosurf = mlab.contour3d(S, vmin=5.0, transparent=true)

isosurf[:contour][:number_of_contours] = 25
isosurf[:actor][:property][:opacity] = 0.3
