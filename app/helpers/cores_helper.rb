module CoresHelper
  def acct_merge_sts_indicator(core)
    sts = core.acct_merge_sts
    if sts == "Merge"
      html = <<-HTML
      <td class='bg-light-green geo w-xsm'>#{fa_icon 'plus shadow', class: 'fa-gray'}</td>
      HTML
    elsif sts == "Flag"
      html = <<-HTML
      <td class='bg-light-orange geo w-xsm'>#{fa_icon 'flag shadow', class: 'fa-gray'}</td>
      HTML
    elsif sts == "Drop"
      html = <<-HTML
      <td class='bg-light-red geo w-xsm'>#{fa_icon 'minus shadow', class: 'fa-gray'}</td>
      HTML
    else
      html = <<-HTML

      HTML
    end
    html.html_safe
  end

  def indicate_match(match_sts)
    if match_sts == "Same"
      "bg-light-green"
    else
      "bg-light-red"
    end
  end
end
