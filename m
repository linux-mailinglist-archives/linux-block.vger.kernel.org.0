Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1108F3C264A
	for <lists+linux-block@lfdr.de>; Fri,  9 Jul 2021 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhGIOxo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Jul 2021 10:53:44 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41576 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhGIOxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jul 2021 10:53:44 -0400
Received: by mail-pf1-f170.google.com with SMTP id f17so8916038pfj.8;
        Fri, 09 Jul 2021 07:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpfPI7ngx6mlsmZd2ED2U6VHIGN9urCO9ch5mlaeWvU=;
        b=k+J6u9DVIqCnb92UcDxLtlsc2s4Ot9s7v1fhljgBxknZI701V4j94KkEu3K5C32SNE
         6bWNHe55T0x/vD7MOyqIYrAoA8EFK1ozM5f/LgFzSzeCKtRFMHUlqEOkIN648QBORxgr
         9msWGGWbNJNy+Nkcl94bGvwizbRuNEeEGrBZgLdJuXPwwEVyVZ3xlThzJHETfR0CT4ZE
         QOFTNNhXdemkv7EAIEdg245ryDDmYIJxUifPkXuY1X5xmD+yDRlCQ4jKU/ipTAYG90vm
         OoM9I7UHTeFltI9WHGl+PUldZyhavbGfuQjKV6KFwBZK8wnEID73aI14YxE41bbtBhqw
         Xn/A==
X-Gm-Message-State: AOAM530ZLdBhMi4yg5Y5CNJcO67DYOLg7F2BFXCo37U8Z7sxLheHyvxC
        TCIo2BuvN4XBFGK3bxzNLy3HT2M8E7s=
X-Google-Smtp-Source: ABdhPJwHjqZ1rurEi8luN3B+F7vQoExkjpk1yyTpqSr7YDorUz+Zr0x4F6ElEA/Qv5tUhQBZGSALpw==
X-Received: by 2002:a62:cd44:0:b029:316:643c:1ee3 with SMTP id o65-20020a62cd440000b0290316643c1ee3mr38229513pfg.5.1625842259356;
        Fri, 09 Jul 2021 07:50:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:eeaf:c266:e6cc:b591? ([2601:647:4000:d7:eeaf:c266:e6cc:b591])
        by smtp.gmail.com with ESMTPSA id m34sm7625673pgb.85.2021.07.09.07.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:50:58 -0700 (PDT)
Subject: Re: WARNING at blktests block/008 in ttwu_queue_wakelist()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210609065339.aecrkqc6dj3xgbiw@shindev.dhcp.fujisawa.hgst.com>
 <DM6PR04MB70815A73F340B0E35F91B75CE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <aef11aa8-1886-5460-21cd-a8e1161514db@acm.org>
Date:   Fri, 9 Jul 2021 07:50:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70815A73F340B0E35F91B75CE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 11:55 PM, Damien Le Moal wrote:
> + Jens and linux-kernel

Since console_sem is involved, could this be a printk() bug?

Bart.
