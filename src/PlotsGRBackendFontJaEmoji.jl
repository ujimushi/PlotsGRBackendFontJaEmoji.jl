"""
    PlotsGRBackendFontJaEmoji

`Plots.jl(GR backend)`で日本語と絵文字を使える環境を
手軽に構築します。

使い方:

```julia
using Plots
import GR
using PlotsGRBackendFontJaEmoji

gr()

plot(sin; title="日本語")
```
"""
module PlotsGRBackendFontJaEmoji
using Plots
import GR

export FONT_JA_EMOJI, plots_gr_register_user_font
const FONT_JA_EMOJI = "cica"


function _get_plot_gr_module()
    _mod = if isdefined(Plots, :gr_font_family)
        Plots
    elseif isdefined(Plots, :PlotsBase) &&
        isdefined(Plots.PlotsBase, :get_backend_module)
        _t = Plots.PlotsBase.get_backend_module(:GR)
        isnothing(_t) ? nothing : _t[1]
    else
        nothing
    end
    if isnothing(_mod)
        @info "GRモジュールが見つかりませんでした"
    end
    _mod
end

"""
    plots_gr_register_user_font(fontname, fontpath)

`Plots.jl(GR backend)`で利用するためのフォントを登録する

* `fontname`: フォント名の識別子
* `fontpath`: フォントファイルへの絶対パス
              or OS登録済フォントファイル名
"""
function plots_gr_register_user_font(fontname::AbstractString,
                                     fontpath::AbstractString)
    font_id = lowercase(fontname)
    _module = _get_plot_gr_module()
    if isnothing(_module) return end
    if !haskey(_module.gr_font_family, font_id)
        gff_id = GR.loadfont(fontpath)
        if gff_id > 0
            _module.gr_font_family[font_id] = gff_id
        else
            @info "「$fontname」の登録に失敗しました"
        end
    else
        @info "「$fontname」は既に登録されています"
    end
    nothing
end

function __init__()
    cica_font_path = normpath(@__DIR__, "..", "font", "Cica-Regular.ttf")
    plots_gr_register_user_font(FONT_JA_EMOJI, cica_font_path)
    default(fontfamily=FONT_JA_EMOJI)
    nothing
end

end # module PlotsGRBackendFontJaEmoji
