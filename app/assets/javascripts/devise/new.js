function addEventListener(el, type, func) {
    if (el.addEventListener) {
        el.addEventListener(type, func, false);
    } else if (el.attachEvent) {
        el.attachEvent('on' + type, func);
    }
}
function hide(el) {
    el.classList.add('hidden');
}
function show(el) {
    el.classList.remove('hidden');
}
function fieldDisplay(radio) {
    var organizationGroup = radio.form.querySelector(".user_organization"),
		registrationCodeGroup = radio.form.querySelector(".user_registration_code");
    if (radio.checked) {
        show(registrationCodeGroup);
        hide(organizationGroup);
    } else {
    	show(organizationGroup);
        hide(registrationCodeGroup);
    }
}

function setupRadioEventHandler(radio) {
    var fields = radio.form.elements[radio.name],
        i,
        fieldDisplayHandler = function () {
            fieldDisplay(radio);
        };
    for (i = 0; i < fields.length; i += 1) {
        addEventListener(fields[i], 'click', fieldDisplayHandler);
    }
}

window.onload = function () {
    var studentRadio = document.querySelector('[type="radio"][value="0"][id="user_registration_role_0"]'),
    	form = studentRadio.form;
    	organizationGroup = form.querySelector(".user_organization"),
    	registrationCodeGroup = form.querySelector(".user_registration_code");
    hide(registrationCodeGroup);
    hide(organizationGroup);
    setupRadioEventHandler(studentRadio);
}