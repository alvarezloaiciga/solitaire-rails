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

$(document).ready(function() {
  disableNotDroppableCards();
});

var draggableOptions = {
    revert: function(isValidMove) {
      if(!isValidMove) {
        $('.dragging-card').detach().appendTo($('.original-parent'));
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
    $('.dragging-card').detach().appendTo($(this).parent());
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
  $('.product_line_column div.card:last-child').droppable({ disabled: false });
}

$(".empty-column").droppable({
  drop: function(event, ui) {
    createOriginCardID(ui.draggable);
    columnID = $("#destiny_column_id").val();
    ui.draggable.addClass("product-line-card");

    destinyColumnID = $("#destiny_column_id");
    destinyColumnID.val($(this).attr('id'));
    $('dragging-card').detach().appendTo($(this));
    //$(this).append(originCard);

    $("#destiny").text(destinyColumnID.val());
    //$(".edit_solitaire_game").submit();
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

  originCardID.val(cardDiv.attr('id'));
  originColumnID.val($('.original-parent').attr('id'));

  $("#origin").text(originCardID.val() + " -> ");
};

function moveOriginToDestiny(destinyCard, originCard) {
  columnID = $("#destiny_column_id").val();

  if(columnID.match(/product_line_column/)){
    originCard.addClass("product-line-card");
  }

  //$(".edit_solitaire_game").submit();
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
