Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D0B42BD83
	for <lists+linux-block@lfdr.de>; Wed, 13 Oct 2021 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhJMKqw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Oct 2021 06:46:52 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36357 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhJMKqv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 06:46:51 -0400
Received: by mail-wr1-f50.google.com with SMTP id o20so6835637wro.3;
        Wed, 13 Oct 2021 03:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FZcgHgT5RXoyQXc94skH7rfOkpb8jmZEGAkCK54EJMywHQs5qh6820IydqDgn7jxTz
         PQU90eA8WZUc4o7yacifxth8QNEC+SQs8d0Wav44v4P0zPdCkC9tSHWm68qIyqoEdbpl
         1Yxc5Dpw5JflCSM76xk874Zm2MdZ9pIwyoNC1g2CNvX0DVC9oOcu1XtlHdSSbBIOJ0b9
         jYmHuhrGRQYhrmvycOvAU9BzULsGu6wwgd0GepWHVvknkjSFOjhTCoEalcTKwOprXl9M
         eQw1/Cc6kKSwA4z/7or+kN0yQV2vqB3PrTM5KFJwAgbognu0uAyCAuZYVTNk+yez4ETv
         AR9g==
X-Gm-Message-State: AOAM531pqas9OMdEOrODDdBWmVKljQyJSuxYjU0ZtwqQ3Tx9M1S7Jghk
        29ADt5Y3v/VBm69wJUKkxzM=
X-Google-Smtp-Source: ABdhPJwkE7s/yUrnb2NTOS+U/h/aTochobgn/xQEC0SX1NDliyp6ZGkM4DGCgN3hmJFIcue9rPM5mA==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr12313935wmq.158.1634121887275;
        Wed, 13 Oct 2021 03:44:47 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f3sm4896127wmb.12.2021.10.13.03.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 03:44:46 -0700 (PDT)
Subject: Re: [PATCH 09/16] block: replace the spin argument to blk_iopoll with
 a flags argument
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-10-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a019990a-ef88-0593-d362-f4c9c639cb21@grimberg.me>
Date:   Wed, 13 Oct 2021 13:44:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
