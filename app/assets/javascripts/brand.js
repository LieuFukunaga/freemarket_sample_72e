$(function(){
  $(".brand-area").on("mouseenter", function(){
    $(".brands").removeClass("negative");
  });
  $(".brand-area").on("mouseleave", function(){
    $(".brands").addClass("negative");
  });
});