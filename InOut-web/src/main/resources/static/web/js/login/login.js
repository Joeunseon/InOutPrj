/**
 * Login
 * 로그인
 */

/** 이벤트 : keypress -> ID, 비밀번호 */
$('#userId, #userPwd').keypress(function (event)
{
    /** 키 입력 분기 */
    if ( event.which == 13 )
    { /** 엔터 키의 경우 */
        /** 로그인 */
        clickLogin();
    } /** 엔터 키의 경우 */
});

/** ID, 비밀번호 keyup 이벤트 */
$('#userId, #userPwd').keyup(function(event)
{
    /** ID, 비밀번호 값 존재 유무 분기 */
    if ( $('#userId').val() != '' && $('#userPwd').val() != '' )
    { /** ID, 비밀번호 값 있을 경우 */
        /** 설정 : 로그인 버튼 비활성화 */
        $('#btn-login').attr('disabled', false);
    }
});

/** 쿠키 로그인 아이디 */
var loginId = getCookie('inoutloginid');

/** 존재 유무 분기 */
if ( loginId )
{ /** 쿠키에서 로그인 아이디가 있을 경우 */
    /** 설정 : 로그인 ID 입력*/
    $('#userId').val(loginId);
    /** 설정 : ID 기억하기 */
    $('#save').prop('checked', true);
} /** 쿠키에서 로그인 아이디가 있을 경우 */

/** input 이벤트 */
$('.form-control').on('input' , function ()
{
    /** active class 추가 */
    $(this).addClass('active');
});

function clickLogin()
{
    /** 아이디 */
    var id = $.trim($('#userId').val());
    /** 비밀번호 */
    var pw = $.trim($('#userPwd').val());
    
    /** form */
    var form = $('<form>');
    
    /** 파라미터 */
    var param =
    {
        userId : id,
        userPwd : pw
    };
    
    /** 키 설정 */
    for ( var key in param )
    {
        /** hidden */
        var hidden = $('<input>' ,
        {
            type : 'hidden',
            name : key,
            value : param[key]
        });
        
        /** append */
        hidden.appendTo(form);
    }
    
    /** 아이디 저장 */
    if ( $('input:checkbox[id=\'save\']').is(':checked') )
    {
        /** 쿠키 설정 */
        setCookie('inoutloginid' , id , 7);
    }
    else
    {
        /** 쿠키 삭제 */
        deleteCookie('inoutloginid');
    }
    
    /** AJAX */
    $.ajax({
        url : '/doLogin',
        type : 'POST',
        data : form.serialize(),
        dataType : 'json',
        async : false,
        success : function ( data , textStatus , xhr )
        {
            /** 로그 출력 */
            //console.log(textStatus);
            //console.log(xhr);
            
            /** data.result 가 true 이면 */
            if ( data.result )
            {
                location.href = '/hist';
            }
            else
            {
                /** 서버 메시지 표시 */
                $('.alert-none').html(data.message);
                /** 알림 표시 */
                $('.alert-none').show();
            }
        }
    });
}

/**
 * 쿠키 값 설정
 * @param name 쿠키 키
 * @param value 쿠키 값
 * @param expiredays 쿠키 값 기한
 */
function setCookie(name, value, expiredays)
{
    var today = new Date();
    today.setDate(today.getDate() + expiredays);
    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';';
}

/**
 * 쿠키 값 취득
 * @param name 쿠키 키
 */
function getCookie(name)
{
    var cName = name + '=';
    var x = 0;
    while ( x <= document.cookie.length )
    {
        var y = x + cName.length;
        if ( document.cookie.substring(x, y) == cName )
        {
            if ( (endOfCookie = document.cookie.indexOf(';', y)) == -1 ) endOfCookie = document.cookie.length;
            return unescape(document.cookie.substring(y, endOfCookie));
        }
        x = document.cookie.indexOf(' ', x) + 1;
        if ( x == 0 ) break;
    }
    
    return '';
}

/**
 * 쿠키 삭제
 * @param name 쿠키 키
 */
function deleteCookie(name)
{
    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}