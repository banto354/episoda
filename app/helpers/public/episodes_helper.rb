module Public::EpisodesHelper
  def render_with_tags(content)
    # タグにリンクを作成
    simple_format(content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/tag/#{word.delete("#")}"}.html_safe)
  end
end
