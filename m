Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47AB27B17C
	for <lists+linux-block@lfdr.de>; Mon, 28 Sep 2020 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgI1QLl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Sep 2020 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgI1QLh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 12:11:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E3C0613CF
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2020 09:11:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g72so1444540qke.8
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2020 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=d111Hn5E6/L1IL1iw8/0aKsHRupBoWHJoeEulSFTTXo=;
        b=c6QGQyABV5pM8F/EOWUqFP2iV8Y0Lu9vizM92vHofHOxvi1nLbdHc/LBj633kMl+TA
         L01yZZu/Cv+q1kfL99NaZ1J4Q016FCPRl78yG7hswvoe0y6BJ2tccZo36buY8JGmuNRZ
         l0wYqmwYxFh6Duf0gDZMrP+JwzB9o0eSeyZ/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=d111Hn5E6/L1IL1iw8/0aKsHRupBoWHJoeEulSFTTXo=;
        b=ghh5ziQXw/OnNnnmECMJrsKf2Q45xvxEM+tIXOuGQ4Hr1bHtJMiSo3M9bn9UnzZ9Xk
         59H486eOJKGfkQA0BYpKbtBgn0sl0paJuUBGtnI61/CLzWfPTFPjCSpjR31WzlUqmKKe
         8irLKt8vrZwifWF+m6Ptfk5z1BPCQ9JflS0gvxd8uuZVPD2mbMomGdjKF1I3jkM9jnWS
         1HBZYbtO3sMRe7qWTKWD0vMMVN4t70SCgN8lfcMhvFhcqlMwuMCTscD9u5mLsJUTHJhz
         6tkuKREFU6h9KzK48Zgw3ehOorVUFoVZwC6ewOfJBq20TLUf3tcssOU6+B/rn3G5nCwO
         eDEw==
X-Gm-Message-State: AOAM531+G6DjaPSpTbVpuwwR2U4O3uQ9/2h+0jChmeOF1pETZm8wD5/V
        uIupjsNeVkebXMeAvYISkv90/2X1FGZxcJlQ41srHA==
X-Google-Smtp-Source: ABdhPJyhTOt6mlkaH6eCtAf9ifBKpE+b/UjFdXmpfP+nLenl6yS3z9pSQ1NHBD3rtmrJHxJQxB+Zka1aWaJWbFs4yag=
X-Received: by 2002:a37:68c7:: with SMTP id d190mr151524qkc.127.1601309496070;
 Mon, 28 Sep 2020 09:11:36 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
 <df6a3bd3-a89e-5f2f-ece1-a12ada02b521@kernel.dk>       <379ef8a4-5042-926a-b8a0-2d0a684a0e01@huawei.com>
 <yq1363xbtk7.fsf@ca-mkp.ca.oracle.com> <32def143-911f-e497-662e-a2a41572fe4f@huawei.com>
 <yq1imcdw6ni.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1imcdw6ni.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIEYzmMwLj9Hjt1oYRTL2F1ptHELAF941hsAQBmOwQB2gFb0gGSrJbvAc3Tg4Oo5NZRgA==
Date:   Mon, 28 Sep 2020 21:41:33 +0530
Message-ID: <32574da3d8de863ff38347ef6ead9b35@mail.gmail.com>
Subject: RE: [PATCH v8 00/18] blk-mq/scsi: Provide hostwide shared tags for
 SCSI HBAs
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     jejb@linux.ibm.com, don.brace@microsemi.com, ming.lei@redhat.com,
        bvanassche@acm.org, dgilbert@interlog.com,
        paolo.valente@linaro.org, hare@suse.de, hch@lst.de,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        chenxiang66@hisilicon.com, luojiaxing@huawei.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b8d54805b061eb51"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000b8d54805b061eb51
Content-Type: text/plain; charset="UTF-8"

>
> John,
>
> > Have you had a chance to check these outstanding SCSI patches?
> >
> > scsi: megaraid_sas: Added support for shared host tagset for
cpuhotplug
> > scsi: scsi_debug: Support host tagset
> > scsi: hisi_sas: Switch v3 hw to MQ
> > scsi: core: Show nr_hw_queues in sysfs
> > scsi: Add host and host template flag 'host_tagset'
>
> These look good to me.
>
> Jens, feel free to merge.

Hi Jens, Gentle ping. I am not able to find commits for above listed scsi
patches. I want to use your repo which has above mentioned patch for
<scsi:io_uring iopoll> patch submission.  Martin has Acked the scsi
patches.

>
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
>
> --
> Martin K. Petersen	Oracle Linux Engineering

--000000000000b8d54805b061eb51
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
yfWKfxJx8FcWmsjkSlrwDu+oVuDUa2wqeKBU12HQ4JAVd+LOb5edsbbFQxgGHu+MPuc/1hl9kTkC
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQU4dX1
Yg4eoWXbqyPW/N1ZD/LPIWcwDQYJKoZIhvcNAQELBQADggEBABBuHYKGUwHIhCjd3LieJwKVuJNr
YohEnZzCoNaOj33/j5thiA4cZehCh6SgrIlFBIktLD7jW9Dwl88Gfcy+RrVa7XK5Hyqwr1JlCVsW
pNj4hlSJMNNqxNSqrKaD1cR4/oZVPFVnJJYlB01cLVjGMzta9x27e6XEtseo2s7aoPS2l82koMr7
8S/v9LyyP4X2aRTWOg9RG8D/13rLxFAApfYvCrf0quIUBWw2BXlq3+e3r7pU7j40d6P04VV3Zxws
M+LbYxcXFT2gXvoYd2Ms8zsLrhO2M6pMzeNGWk2HWTof9s7EEHDjis/MRlbYSNaohV23IUzNlBw7
1FmvvW5GKK0xggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDDSdoX7GqonhoE7TszANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgy08T8zb2
3Ba6jERxRWtqDfLZKY8wOMjC4kiNDPKFq34wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAwOTI4MTYxMTM2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFm0ioyFQTFLjJ0YIcb7wTZyY3JE
5QXREwn1TJiMMLJ7CXXZpzRz4hd50AmftViwkkzedb2MxmqDscDJwJ8ieLu5wprOjbGc9m5pqgt1
n+VQa1whhpS072EfmqdHE+DfvywHSbnYaOBLT04jTw+AeG3IwclhvGqtNFuCLp5wCukr3b/ykgmS
x7wR8n1xNw2BEUpkEKxmnrJvyBKk3p5PapTuTwbpWE64dh0FbaKce0Jb2vMJ1Y4kAPeE88XbjGSY
3sjJ6WJVctszVEwy9mQPZAHLGKpkanAkPVp6JQTSNfZJIO1JP82qnnKWe8jtcJoP3IUCppns27w1
Qk/Soy0+0Lk=
--000000000000b8d54805b061eb51--
