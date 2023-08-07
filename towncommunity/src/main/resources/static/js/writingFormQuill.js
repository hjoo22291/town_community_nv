/**
 * 글 작성 페이지 에디터 코드
 */

var toolbarOptions = [
  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
  ['blockquote'],
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  ['clean'],   	                                    // remove formatting button
  ['image'],
];
		
// quill.js 실행 코드
function quilljsediterInit(){
    var option = {
        modules: {
            toolbar: toolbarOptions,
        },
        placeholder: '자세한 내용을 입력해 주세요!',
        theme: 'snow'
    };

    quill = new Quill('#editor', option);
    quill.on('text-change', function() {
        document.getElementById("quill_html").value = quill.root.innerHTML;
    });

    quill.getModule('toolbar').addHandler('image', function () {
        selectLocalImage();
    });
}

/* 이미지 콜백 함수 */
function selectLocalImage() {
    const fileInput = document.createElement('input');
    fileInput.setAttribute('type', 'file');

    fileInput.click();

    fileInput.addEventListener("change", function () {  // change 이벤트로 input 값이 바뀌면 실행
        const formData = new FormData();
        const file = fileInput.files[0];
        formData.append('uploadFile', file);

        $.ajax({
            type: 'post',
            enctype: 'multipart/form-data',
            url: '/board/imageUpload',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function (data) {
                const range = quill.getSelection(); // 사용자가 선택한 에디터 범위
                data.uploadPath = data.uploadPath.replace(/\\/g, '/');
                quill.insertEmbed(range.index, 'image', "/display?fileName=" + data.uploadPath + "/" + data.uuid + "_" + data.fileName);
            },
            error: function(request,status,error) {
			      		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			      		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			      }
        });

    });
}

quilljsediterInit();