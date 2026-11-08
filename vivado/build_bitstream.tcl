# -----------------------------------------------------------------------------
# Creează proiectul și rulează sinteza, implementarea și generarea bitstream-ului.
#
#     vivado -mode batch -source vivado/build_bitstream.tcl
#
# Rezultat: build/termostat/termostat.runs/impl_1/top_level_Termostat.bit
# -----------------------------------------------------------------------------

source [file join [file dirname [info script]] create_project.tcl]

launch_runs synth_1 -jobs 4
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

puts "Bitstream: [get_property DIRECTORY [get_runs impl_1]]/top_level_Termostat.bit"
