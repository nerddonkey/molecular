# Recorded script from Mayavi2
from numpy import array
try:
    engine = mayavi.engine
except NameError:
    from mayavi.api import Engine
    engine = Engine()
    engine.start()
if len(engine.scenes) == 0:
    engine.new_scene()
# ------------------------------------------- 
iso_surface = engine.scenes[0].children[0].children[0].children[0]
iso_surface.contour.number_of_contours = 25
iso_surface.contour.number_of_contours = 24
iso_surface.actor.property.opacity = 0.3
iso_surface.actor.property.representation = 'wireframe'
scene = engine.scenes[0]
scene.scene.camera.position = [-24.088087748612825, 54.043636243007882, -20.312772566388141]
scene.scene.camera.focal_point = [10.5, 10.5, 10.5]
scene.scene.camera.view_angle = 30.0
scene.scene.camera.view_up = [-0.83905247095357238, -0.44344846030815965, 0.31518948909668232]
scene.scene.camera.clipping_range = [30.543293818432765, 105.3089999072057]
scene.scene.camera.compute_view_plane_normal()
scene.scene.render()
scene.scene.camera.position = [-0.21624454119673653, 64.056907352709914, -22.03660711173778]
scene.scene.camera.focal_point = [10.5, 10.5, 10.5]
scene.scene.camera.view_angle = 30.0
scene.scene.camera.view_up = [-0.86716454004679733, 0.12011259678296414, 0.4833204160590357]
scene.scene.camera.clipping_range = [34.151730321896927, 100.76672179606069]
scene.scene.camera.compute_view_plane_normal()
scene.scene.render()
iso_surface.actor.property.representation = 'points'
scene.scene.camera.position = [-16.969759227966954, 59.926624480558068, -18.555673198404648]
scene.scene.camera.focal_point = [10.5, 10.5, 10.5]
scene.scene.camera.view_angle = 30.0
scene.scene.camera.view_up = [-0.90131935427265031, -0.35515792607811608, 0.24796424975674275]
scene.scene.camera.clipping_range = [31.433138236144224, 104.18886912008608]
scene.scene.camera.compute_view_plane_normal()
scene.scene.render()
iso_surface.actor.property.representation = 'surface'
iso_surface.actor.property.line_width = 7.100399971008301
iso_surface.actor.property.line_width = 7.1004000000000005
scene.scene.camera.position = [-1.5993345888863955, 33.535417669473446, -47.506781154414412]
scene.scene.camera.focal_point = [10.5, 10.5, 10.5]
scene.scene.camera.view_angle = 30.0
scene.scene.camera.view_up = [-0.42060577452424525, -0.86987202242203165, -0.25770806553979742]
scene.scene.camera.clipping_range = [35.242529284390535, 99.393630639755415]
scene.scene.camera.compute_view_plane_normal()
scene.scene.render()
iso_surface.actor.property.line_width = 1.6332000494003296
iso_surface.actor.property.line_width = 1.6332
scene.scene.camera.position = [37.994678650151187, 59.152227800736739, -19.81195144736159]
scene.scene.camera.focal_point = [10.5, 10.5, 10.5]
scene.scene.camera.view_angle = 30.0
scene.scene.camera.view_up = [0.89589043619482356, -0.30506464316716986, 0.32297970497221107]
scene.scene.camera.clipping_range = [31.282433765678405, 104.37857499873776]
scene.scene.camera.compute_view_plane_normal()
scene.scene.render()
iso_surface.actor.property.line_width = 1.0
module_manager = engine.scenes[0].children[0].children[0]
module_manager.scalar_lut_manager.scalar_bar_representation.minimum_size = array([1, 1])
module_manager.scalar_lut_manager.scalar_bar_representation.position2 = array([ 0.17,  0.8 ])
module_manager.scalar_lut_manager.scalar_bar_representation.position = array([ 0.82,  0.1 ])
module_manager.scalar_lut_manager.scalar_bar_representation.maximum_size = array([100000, 100000])
module_manager.scalar_lut_manager.show_scalar_bar = True
module_manager.scalar_lut_manager.show_legend = True
module_manager.scalar_lut_manager.scalar_bar.height = 0.8
module_manager.scalar_lut_manager.scalar_bar.width = 0.17
module_manager.scalar_lut_manager.scalar_bar.position2 = array([ 0.17,  0.8 ])
module_manager.scalar_lut_manager.scalar_bar.position = array([ 0.82,  0.1 ])
module_manager.scalar_lut_manager.show_scalar_bar = False
module_manager.scalar_lut_manager.show_legend = False
module_manager.scalar_lut_manager.use_default_range = False
module_manager.scalar_lut_manager.scalar_bar.position2 = array([ 0.17,  0.8 ])
module_manager.scalar_lut_manager.scalar_bar.position = array([ 0.82,  0.1 ])
module_manager.scalar_lut_manager.data_range = array([  0.5       ,  18.70828693])
module_manager.scalar_lut_manager.scalar_bar.position2 = array([ 0.17,  0.8 ])
module_manager.scalar_lut_manager.scalar_bar.position = array([ 0.82,  0.1 ])
module_manager.scalar_lut_manager.data_range = array([  0.5,  20. ])
scene.scene.camera.position = [51.760643569285058, 41.868953098047349, -26.315202001048156]
scene.scene.camera.focal_point = [10.5, 10.5, 10.5]
scene.scene.camera.view_angle = 30.0
scene.scene.camera.view_up = [0.049279330221900425, 0.73229979165615211, 0.67919699848662263]
scene.scene.camera.clipping_range = [30.394521882489379, 105.49627312305344]
scene.scene.camera.compute_view_plane_normal()
scene.scene.render()
module_manager.scalar_lut_manager.scalar_bar.position2 = array([ 0.17,  0.8 ])
module_manager.scalar_lut_manager.scalar_bar.position = array([ 0.82,  0.1 ])
module_manager.scalar_lut_manager.data_range = array([  0.98464668,  18.70828693])
module_manager.scalar_lut_manager.use_default_range = True
