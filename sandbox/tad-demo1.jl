
using PyCall
@pyimport mayavi.mlab as mlab

pygui_start(:qt) # make mayavi non-blocking

fig = mlab.figure("molecular", bgcolor=(1.0,1.0,1.0), fgcolor=(0, 0, 0), size=(800, 800))
scene = mlab.gcf()[:scene]
scene[:magnification] = 2
camera = scene[:camera]
scene[:light_manager][:light_mode] = "raymond"#vtk"

# scene[:show_axes] = true
nothing

include("ndgrid_rak.jl")

num = 200
lim = 5.0
x = linspace(-3.0, 7.0, num)
y = linspace(-lim,lim, num)
z = linspace(-lim, lim, num)

X, Y, Z = ndgrid(x, y, z)

# create a 3D phantom
P1 = 3./(X.^2+2.0*Y.^2+0.5*Z.^2+1.0)
P2 = 3./(1.5*(X-3.5).^2+0.5*Y.^2+0.5*Z.^2+1.0);
P3 = 3./(0.25*(X-5).^2+0.25*(Y-4.0).^2+1.0*(Z-3).^2+1.0);
P0 = 100.0 * (P1 + P2 + P3)
nothing

mlab.clf()

src = mlab.pipeline[:scalar_field](P0)
mlab.outline(opacity=0.3, line_width=2.0, color=(1.0,0.0,0.0))

#mlab.pipeline[:volume](src, vmin=min=40.0)
mlab.pipeline[:iso_surface](src,
contours=linspace(40.0,320.0,15), opacity=0.2, colormap="copper")
#mlab.view(azimuth=30, elevation=65, distance="auto")
#    mlab.view(azimuth=115, elevation=55,
#scene[:isometric_view]()

mlab.view(azimuth=15, elevation=95,
         distance=3.0*num,
         focalpoint=(num/2,num/2,num/2))
mlab.savefig("images/temp.png", magnification = 2)
#sleep(3.0)

;convert "images/temp.png" -trim +repage "images/image-015-095.png"

mlab.view(azimuth=30, elevation=95,
         distance=3.0*num,
         focalpoint=(num/2,num/2,num/2))
mlab.savefig("images/temp.png", magnification = 2)
#sleep(3.0)

;convert "images/temp.png" -trim +repage "images/image-030-095.png"


