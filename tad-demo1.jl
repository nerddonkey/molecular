using ProgressMeter
using PyCall
@pyimport mayavi.mlab as mlab

pygui_start(:qt) # make mayavi non-blocking

function __ndgrid{T}(v1::AbstractVector{T}, v2::AbstractVector{T})
   m, n = length(v1), length(v2)
   v1 = reshape(v1, m, 1)
   v2 = reshape(v2, 1, n)
   (repmat(v1, 1, n), repmat(v2, m, 1))
end

function __ndgrid{T}(vs::AbstractVector{T}...)
    n = length(vs)
    sz = map(length, vs)
    out = ntuple(i->Array(T, sz), n)
    s = 1
    for i=1:n
        a = out[i]::Array
        v = vs[i]
        snext = s*size(a,i)
        ndgrid_fill(a, v, s, snext)
        s = snext
    end
    out
end

function ndgrid_fill(a, v, s, snext)
    for j = 1:length(a)
        a[j] = v[div(rem(j-1, snext), s)+1]
    end
end

fig = mlab.figure("molecular", bgcolor = (1.0,1.0,1.0), fgcolor = (0, 0, 0), size = (800, 800))
scene = mlab.gcf()[:scene]
scene[:magnification] = 2
camera = scene[:camera]
scene[:light_manager][:light_mode] = "raymond"#vtk"
# scene[:show_axes] = true

num = 200
lim = 5.
x = linspace(-3., 7., num)
y = linspace(-lim, lim, num)
z = linspace(-lim, lim, num)
X, Y, Z = __ndgrid(x, y, z)

# create a 3D phantom
P1 = 3./(X.^2+2.0*Y.^2+0.5*Z.^2+1.0)
P2 = 3./(1.5*(X-3.5).^2+0.5*Y.^2+0.5*Z.^2+1.0);
P3 = 3./(0.25*(X-5).^2+0.25*(Y-4.0).^2+1.0*(Z-3).^2+1.0);
P0 = 100.0 * (P1 + P2 + P3)

mlab.clf()

src = mlab.pipeline[:scalar_field](P0)
mlab.outline(opacity = 0.3, line_width = 2.0, color = (1.0,0.0,0.0))

#mlab.pipeline[:volume](src, vmin = min = 40.0)
mlab.pipeline[:iso_surface](src,
contours = linspace(40.0,320.0,15), opacity = 0.2, colormap = "copper")

# mlab.view(azimuth = 15, elevation = 95, distance = 3.0*num, focalpoint = (num/2,num/2,num/2))
# mlab.savefig("images/temp.png", magnification = 2)
#
# # ;convert "images/temp.png" -trim +repage "images/image-015-095.png"
#
# mlab.view(azimuth = 30, elevation = 95, distance = 3.0 * num, focalpoint = (num / 2,num / 2,num / 2))
# mlab.savefig("images/temp.png", magnification = 2)
# ;convert "images/temp.png" -trim +repage "images/image-030-095.png"

Ntot = 360
prog = Progress(Ntot, 0.2, "Generating movie frames...", 50)
prog.color = :blue

fstr = "images/density"
destarray = []
for n = 1:Ntot
   # dest = fstr * @sprintf "_%04d.png" n
   dest = "images/density$(@sprintf "_%04d.png" n)"
   push!(destarray, dest)  # remember so we can delete later see \ref{jlref:cleanup}
   mlab.view(azimuth = 1.0 * (n - 1), elevation = 90. + 30. * sind(n - 1),
      distance = 3.0 * num, focalpoint = (num / 2, num / 2, num / 2))
   mlab.savefig(dest, magnification = 2)
   next!(prog)
end

# make movie from pngs http://stackoverflow.com/questions/24682182, see also \ref{jlref:avconv}
pngs = fstr * "_%04d.png"
mov = fstr * ".mov"
options = "-framerate 25 -y -v quiet -f image2 -i"
scaling = "-vf scale='trunc(iw/2)*2:trunc(ih/2)*2'"

if success(`avconv $(split(options)) $pngs $(split(scaling)) $mov`)
   println("Movie written: $(fstr * ".mov")")
else
   println("Movie not written, avconv failed to generate: $(fstr * ".mov")")
end

success(`rm $destarray`)
