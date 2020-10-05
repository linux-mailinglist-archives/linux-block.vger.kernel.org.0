Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDF283CA4
	for <lists+linux-block@lfdr.de>; Mon,  5 Oct 2020 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgJEQkE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Oct 2020 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgJEQkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Oct 2020 12:40:04 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D834C0613CE
        for <linux-block@vger.kernel.org>; Mon,  5 Oct 2020 09:40:04 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id t12so8381091ilh.3
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2020 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZSZ5kzSBxmgO3EkC+7hniQauMKPKijAIyqy5Tah1xM=;
        b=DMCMYq7tDVZ5xjleAe8GNo8iq5nFxJWkkW69qKE/+Z7shdLawIYWij9p36m5dgiHzk
         uveysvQThLy21q3WF+211cm+a04id1rDsMgA7WwcCHEdgwFCjG6ppu/ZcezKwjbRRxZK
         nCeJeJIOIwOzdOphwb/X/7hwpJVcnn839KCM0rcaBa0tchnlpHwNXbskpMdpnrVkH06T
         G6kvyf6Hvr7BMjS/ULe1F28m6fBbFnkrWLdn4TBa2JSY0LoCc9m9bXg4p4PXhj3w3XcM
         VX8gj+qnRlD0yfpfF51qhOjueh53+Zm7PwW3m1uMMMazAabhlHrE3IqocQ1/IM44iMvY
         /uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZSZ5kzSBxmgO3EkC+7hniQauMKPKijAIyqy5Tah1xM=;
        b=V9vNUvcLEnCATliIYi/AyQGGXVdofj63vKbUloOC4/R2ixpmHLBO8oPYrfGRqtqEDi
         XyLd6b9bDGpbjHS1QtoLg3nnX524JIJnzsCY3rmdFdgjeojtwWJqKRQe2tEQ7o6Z3iqG
         9st5TkmRV5jfrzRfTdmRO+WaFPd7Q0KPUSl7CmtMjDMmSaneWIjG69lGJ25+X34+ZdIW
         /BNXqyHqaRertgCdbNE5RXvP8xe0Lhmi8Vo5Oknuq/H42sVxFrh5+jYs4wAQKNtcDNEe
         Vu62AWjYCOBbzH7noAhanWvZVP8CZt9dKplbbnATXPwnMSnZPhPIwzpNZBaRqdT1d4bR
         pGSg==
X-Gm-Message-State: AOAM532c96zgc1cZ4PSyPx0AI8ndAa0mc7qEwsvYwMe+kQdWyBTCA5ka
        k38RuUm25zhnWJjqJiTDRFpJ/8XeXifxaQ==
X-Google-Smtp-Source: ABdhPJzFKmWiZiCSBV85FRdV06a1XMN4EpaIO48aWFIp6OAILZ+bb7mP1aNHeIHPBPIFxi1ILmriVg==
X-Received: by 2002:a05:6e02:11:: with SMTP id h17mr194184ilr.300.1601916003509;
        Mon, 05 Oct 2020 09:40:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a21sm194797ioh.12.2020.10.05.09.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 09:40:02 -0700 (PDT)
Subject: Re: remove bdget() as a public API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20200925160618.1481450-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20798679-80af-50a7-64f7-0af1af78ab16@kernel.dk>
Date:   Mon, 5 Oct 2020 10:40:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925160618.1481450-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/25/20 10:06 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series first cleans up the somewhat odd size handling in
> drbd, and then kill off bdget() as a public API.

Applied, thanks.

-- 
Jens Axboe

