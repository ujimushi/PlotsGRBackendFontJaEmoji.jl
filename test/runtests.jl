using Test
using Plots
using PlotsGRBackendFontJaEmoji
using Images, FileIO

gr()
check_img = load(joinpath(@__DIR__, "text_ja_emoji.png"))
img = begin
    temp_png = tempname() * ".png"
    png(plot(sin; title="日本語🐱"), temp_png)
    load(File{format"PNG"}(temp_png))
end
@test img[1:25, 271:370] ≈ check_img
