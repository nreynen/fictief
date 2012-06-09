function open_tab(id) {
  $(".tabs .tab.current").removeClass("current");
  $(".tabs .tab[tab_id='" + id + "']").addClass("current");
  $(".tabs_contents .tab_content.current").removeClass("current");
  $(".tabs_contents .tab_content.tab_content_" + id).addClass("current");
}
