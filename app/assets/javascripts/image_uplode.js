$(function () {
  // inputのidから情報の取得
  $('#product-image').on('change', function (e) {
  // ここから既存の画像のurlの取得
    var reader = new FileReader();
    reader.onload = function (e) {
        $("#image").attr('src', e.target.result);
    }
  // ここまで
    reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
  });

  $('#product-img').on('change', function (e) {
    // ここから既存の画像のurlの取得
      var reader = new FileReader();
      reader.onload = function (e) {
          $("#img").attr('src', e.target.result);
      }
    // ここまで
      reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
  });


});