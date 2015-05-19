document.ieDetector = function() {
    var browser = { // browser object

            verIE: null,
            docModeIE: null,
            verIEtrue: null,
            verIE_ua: null

        },
        tmp;

    tmp = document.documentMode;
    try {
        document.documentMode = "";
    } catch (e) {};

    browser.isIE = typeof document.documentMode == "number" || eval("/*@cc_on!@*/!1");
    try {
        document.documentMode = tmp;
    } catch (e) {};

    // We only let IE run this code.
    if (browser.isIE) {
        browser.verIE_ua =
            (/^(?:.*?[^a-zA-Z])??(?:MSIE|rv\s*\:)\s*(\d+\.?\d*)/i).test(navigator.userAgent || "") ?
                parseFloat(RegExp.$1, 10) : null;

        var e, verTrueFloat, x,
            obj = document.createElement("div"),

            CLASSID = [
                "{45EA75A0-A269-11D1-B5BF-0000F8051515}", // Internet Explorer Help
                "{3AF36230-A269-11D1-B5BF-0000F8051515}", // Offline Browsing Pack
                "{89820200-ECBD-11CF-8B85-00AA005B4383}"
            ];

        try {
            obj.style.behavior = "url(#default#clientcaps)"
        } catch (e) {};

        for (x = 0; x < CLASSID.length; x++) {
            try {
                browser.verIEtrue = obj.getComponentVersion(CLASSID[x], "componentid").replace(/,/g, ".");
            } catch (e) {};

            if (browser.verIEtrue) break;

        };
        verTrueFloat = parseFloat(browser.verIEtrue || "0", 10);
        browser.docModeIE = document.documentMode ||
        ((/back/i).test(document.compatMode || "") ? 5 : verTrueFloat) ||
        browser.verIE_ua;
        browser.verIE = verTrueFloat || browser.docModeIE;
    };

    return {
        isIE: browser.isIE,
        Version: browser.verIE
    };

}();