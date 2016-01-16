
using PyCall
@pyimport mayavi.mlab as mlab

pygui_start(:qt) # make mayavi non-blocking

fig = mlab.figure(1, bgcolor=(1, 1, 1), fgcolor=(0, 0, 0), size=(1000, 800));
scene = mlab.gcf()[:scene]
# scene[:show_axes] = true

include("ndgrid_rak.jl")

num = 120
lim = 12.0
x = linspace(-lim, lim, num)
y = linspace(-lim,lim, num)
z = linspace(-lim,  lim, num)

X, Y, Z = ndgrid(x, y, z)

# create a 3D phantom
P1 = 3./(X.^2+2.0*Y.^2+0.5*Z.^2+1.0)
P2 = 3./(1.5*(X-3.5).^2+0.5*Y.^2+0.5*Z.^2+1.0);
P3 = 3./(0.25*(X-5).^2+0.25*(Y-4.0).^2+1.0*(Z-3).^2+1.0);
P = 100.0 * (P1 + P2 + P3)
minimum(P), maximum(P)

mlab.clf()

typeno = 2

if typeno==1
   isosurf = mlab.contour3d(P,
                            vmin=0.0,
                            colormap="cool",
                            transparent=true)
   isosurf[:actor][:property][:opacity] = 0.2
   isosurf[:contour][:minimum_contour] = 20.0
   max_cont = 20.0 * div(maximum(P),20.0)
   isosurf[:contour][:maximum_contour] = max_cont
   isosurf[:contour][:number_of_contours] = round(Int64, max_cont/20.0)
   println("$(max_cont)")
elseif typeno==2
   src = mlab.pipeline[:scalar_field](P)
   mlab.pipeline[:iso_surface](src,
   contours=40.0:20.0:120.0, opacity=0.1, colormap="cool", transparent=true)

   mlab.pipeline[:iso_surface](src,
   contours=140.0:20.0:320.0, opacity=0.2, colormap="cool")

   wall_iso = mlab.pipeline[:iso_surface](src,
                                          contours=40.0:40.0,
                                          opacity=0.03,
                                          line_width=0.2,
                                          color=(0,0,0))
   wall_iso[:actor][:property][:representation] = "wireframe"
else
   src = mlab.pipeline[:scalar_field](P)
   mlab.pipeline[:volume](src, vmin=min=40.0)
   mlab.pipeline[:iso_surface](src,
   contours=linspace(140.0,320.0,10), opacity=0.5, colormap="cool")
end

mlab.view(azimuth=115, elevation=105)
mlab.draw()
