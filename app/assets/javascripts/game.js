$(".card").click(function(){
  number = $(this).text().trim();
  if( number === "--"){
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
  originCard.addClass("card card-selected");
  destinyCard.after(originCard);
};

function style_children(parent, select) {
  parent.toggleClass("card-selected");
  parent.children().each(function() {
    style_children($(this));
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
