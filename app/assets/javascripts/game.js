window.onresize = function(event) {
  var bodyWidth = $(document).width();
  if(bodyWidth < 1370){
    console.log(bodyWidth);
    $("#header").height(bodyWidth*0.167);
  }
  else{
      $("#header").height(222);
  }
};

$("#next-card-trigger").click(function(){
  $(this).parent().submit();
});

/*$(".empty-column").click(function(){
  if($("#origin_card_id").val()  != "") {
    originCard = $(".card-selected");
    originCard.removeClass();
    columnID = $("#destiny_column_id").val();
    originCard.addClass("card card-selected product-line-card");

    destinyColumnID = $("#destiny_column_id");
    destinyColumnID.val($(this).attr('id'));
    $(this).empty();
    $(this).append(originCard);

    $("#destiny").text(destinyColumnID.val());
    $(".move-card-form").submit();
  }
});

$("body").delegate('.card', 'click', function(){
  if( $(this).hasClass("card-hidden")){
    alert("Sorry it's hidden");
  } else {
    console.log($(this));
    selectRelevantCards($(this));
    $(this).hasClass("card-selected") ? processSelectedCard($(this)) : deleteCard($(this));*/

var draggableOptions = {
    revert: function(isValidMove) {
      if(!isValidMove) {
        $('.dragging-card').detach().css({top: 0,left: 0}).appendTo($('.original-parent'));
      }
      return !isValidMove;
    },
    start: function(event, ui) {
      $('.last-card').droppable({ disabled: true });
    },
    helper: function(event, ui) {
      $(this).parent().addClass('original-parent');
      selectDraggingCards($(this));
      var draggingGroup = $('<div />', { "class": 'dragging-group feeder_line_column'});
      draggingGroup.appendTo($(this).parent());
      $('.dragging-card').detach().appendTo(draggingGroup);
      return draggingGroup;
    },
    stop: function(event, ui) {
      $('div.dragging-card').removeClass('dragging-card')
      enableDroppableLastCard();
      $('.last-card').removeClass('last-card');
      $('.original-parent').removeClass('original-parent');
    }
};

$( ".card" ).not(".card-hidden").draggable(draggableOptions);

function enableDroppableLastCard() {
  var lastCard = $('.last-card')
  if(lastCard.parent().attr('id') != 'train') {
    lastCard.droppable({ disabled: false });
  }
}

function selectDraggingCards(card) {
  topMostCard(card);
  card.addClass('dragging-card');
  selectLastDraggingCard(card);
  card.nextAll().each(function(index) {
    topMostCard($(this));
    $(this).addClass('dragging-card');
  });
};

function selectLastDraggingCard(card) {
  if(card.is(':last-child')) {
    card.addClass('last-card');
  } else {
    card.nextAll().last().addClass('last-card');
  }
};

$( ".card" ).droppable({
  drop: function(event, ui) {
    createOriginCardID(ui.draggable);
    createDestinyCardID($(this));
    $('.dragging-card').detach().css({top: 0,left: 0}).appendTo($(this).parent());
    addDroppableInOriginColumn();
    removeDroppableDestinyCard($(this));
    moveOriginToDestiny($(this), ui.draggable);
  }
});

function addDroppableInOriginColumn() {
  var last = $('.original-parent div.card:nth-last-child(2)');
  last.droppable({ disabled: false });
}

function removeDroppableDestinyCard(card) {
  card.droppable({ disabled: true });
}

function disableNotDroppableCards() {
  $('.card').droppable({ disabled: true });
  $('.feeder_line_column div.card:last-child').droppable({ disabled: false });
}

$(document).ready(function() {
  disableNotDroppableCards();
});

$(".empty-column").droppable({
  drop: function(event, ui) {
    createOriginCardID(ui.draggable);
    $('dragging-card').detach().css({top: 0,left: 0}).appendTo($(this));
    if($("#origin_card_id").val()) {
      originCard = $(".card-selected");
      originCard.removeClass();
      columnID = $("#destiny_column_id").val();
      originCard.addClass("card card-selected product-line-card");

      destinyColumnID = $("#destiny_column_id");
      destinyColumnID.val($(this).attr('id'));
      $(this).empty();
      $(this).append(originCard);

      $("#destiny").text(destinyColumnID.val());
      //$(".edit_solitaire_game").submit();
    }
  }
});

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

  console.log(cardDiv.attr('id'));

  originCardID.val(cardDiv.attr('id'));
  originColumnID.val($('.original-parent').attr('id'));

  $("#origin").text(originCardID.val() + " -> ");
};

function moveOriginToDestiny(destinyCard, originCard) {
  columnID = $("#destiny_column_id").val();

  if(columnID.match(/product_line_column/)){
    originCard.addClass("product-line-card");
  }

  //destinyCard.after(originCard);
  //$(".move-card-form").submit();
  $(".edit_solitaire_game").submit();
};

function topMostCard(card)
{
    var elements = document.getElementsByClassName("card");
    var highest_index = 0;

    for (var i = 0; i < elements.length - 1; i++) {
        if (parseInt(elements[i].style.zIndex) > highest_index) {
            highest_index = parseInt(elements[i].style.zIndex);
        }
    }
    card.css('zIndex', highest_index + 1);
}

$("#train-card").click(function(){
  $(this).toggleClass("train-card-selected");
});
