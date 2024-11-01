$(document).ready(function () {
  $('#language-dropdown > button').on('click', function() {
    $('.hidden').toggle();
  });

  $('#language-dropdown-content a').on('click', function(event) {
    event.preventDefault();
    const selectedLanguage = $(this).find('img').attr('alt');
    $('#selected-language').text(`Selected Language: ${selectedLanguage}`);
  });
});
