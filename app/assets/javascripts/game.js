$(".card").click(function(){
  origin_card = $("#origin_card_id")
  origin_column = $("#origin_column_id")

  destiny_card = $("#destiny_card_id")
  destiny_column = $("#destiny_column_id")

  number = $(this).text().trim();
  card_id = $(this).attr('id');
  column_id = $(this).parent().attr('id');

  if( number === "--"){
    alert("Sorry it's hidden");
  } else {
    $(this).toggleClass("card-selected");
    selectBelowCards($(this));

    if($(this).hasClass("card-selected")){
      if(origin_card.val()) {
        destiny_card.val(card_id);
        destiny_column.val(column_id);

        $(this).after( $(".card-selected") );
        $("#destiny").text(number);
      } else {
        origin_card.val(card_id);
        origin_column.val(column_id);

        $("#origin").text(number + " -> ");
      }
    } else {
      if(destiny_card.val() == card_id) {
        destiny_card.removeAttr('value')
        destiny_column.removeAttr('value')
        $("#destiny").text("");
      } else {
        origin_card.removeAttr('value')
        origin_column.removeAttr('value')
        $("#origin").text("");
      }
    }
  }
});

function style_children(parent, select) {
  parent.toggleClass("card-selected");
  parent.children().each(function() {
    style_children($(this));
  });
}

function selectBelowCards(card){
  card.nextAll().each(function() {
    style_children($(this));
  });
}
