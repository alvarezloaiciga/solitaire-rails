$(".empty-column").click(function(){
  if($("#origin_card_id").val()) {
    originCard = $(".card-selected");
    originCard.removeClass();
    columnID = $("#destiny_column_id").val();
    originCard.addClass("card card-selected");

    destinyColumnID = $("#destiny_column_id");
    destinyColumnID.val($(this).attr('id'));
    $(this).append(originCard);

    $("#destiny").text(destinyColumnID.val());
    $(".edit_solitaire_game").submit();
  }
});

$(".card").click(function(){
  if( $(this).hasClass("card-hidden")){
    alert("Sorry it's hidden");
  } else {
    selectRelevantCards($(this));
    $(this).hasClass("card-selected") ? processSelectedCard($(this)) : deleteCard($(this));
  }
});

function processSelectedCard(card) {
  if($("#origin_card_id").val()) {
    createDestinyCardID(card);
    moveOriginToDestiny(card);
  } else {
    createOriginCardID(card);
  }
};

function deleteCard(card) {
  destinyCardID = $("#destiny_card_id");
  source =  (destinyCardID.val() == card.attr('id')) ? "destiny" : "origin"
  deleteCardID("source");
};

function deleteCardID(source) {
  cardID = $("#"+source+"_card_id");
  columnID = $("#destiny_column_id");

  cardID.removeAttr('value')
  columnID.removeAttr('value')
  $("#"+source).text("");
};

function createDestinyCardID(cardDiv) {
  destinyCardID = $("#destiny_card_id");
  destinyColumnID = $("#destiny_column_id");

  destinyCardID.val(cardDiv.attr('id'));
  destinyColumnID.val(cardDiv.parent().attr('id'));

  $("#destiny").text(destinyCardID.val());
};

function createOriginCardID(cardDiv) {
  originCardID = $("#origin_card_id");
  originColumnID = $("#origin_column_id");

  originCardID.val(cardDiv.attr('id'));
  originColumnID.val(cardDiv.parent().attr('id'));

  $("#origin").text(originCardID.val() + " -> ");
};

function moveOriginToDestiny(destinyCard) {
  originCard = $(".card-selected");
  originCard.removeClass();
  columnID = $("#destiny_column_id").val();
  originCard.addClass("card card-selected");

  if(columnID.match(/product_line_column/)){
    originCard.addClass("card card-selected product-line-card");
  }

  destinyCard.after(originCard);
  $(".edit_solitaire_game").submit();
};

function style_children(parent, select) {
  parent.toggleClass("card-selected");
  parent.children().each(function() {
    if($(this).hasClass("card")){
      style_children($(this));
    }
  });
};

function selectRelevantCards(card){
  card.toggleClass("card-selected");
  card.nextAll().each(function() {
    style_children($(this));
  });
};

$("#train-card").click(function(){
  $(this).toggleClass("train-card-selected");
});
