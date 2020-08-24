Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA60A24F3F0
	for <lists+linux-block@lfdr.de>; Mon, 24 Aug 2020 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHXI0O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Aug 2020 04:26:14 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33315 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXI0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 04:26:13 -0400
Received: by mail-pg1-f169.google.com with SMTP id o13so4222172pgf.0;
        Mon, 24 Aug 2020 01:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aQ9rPrQx2TTeyieFtrED4ZWS/SQHcBBxbir1kHz+JC+MhAN7IswsaMKSQYMSpzKHBh
         J4ZOzGbfjBC030wyZsNKpejnrjX8czWO2Lg4LjXQpZtVNay6s/y3pgWl2jS+3038edH1
         z6ejoKqZHrpORcPwaHzXjGMvnK2M+uuwSzd6J9g3Wdya8mXKWzaJmlJ67A0IrqkDscCk
         rJuTfzMnQg2a1lvlICbaGDB5eftvoupXWcL555kEebCGI4EQpGZb5uBq2AuRN+Cu9o7P
         +Q8dDKOqkudraQOPC/4mlSAPMa4ToXXQFIc7UMasOeoDkjvCsBg7Vc5CC579GvgRnS7M
         ypcQ==
X-Gm-Message-State: AOAM530hnytZHxPPUDApVjOcKQ/Vfn9zs7K4eet8g6QX6RgdjxodWDL0
        v3LJCB8v6Dss7E/KFcd/YXc=
X-Google-Smtp-Source: ABdhPJzXiZUVeS8YfUquyoWsC4hh0fRsUgPV5IJXXRp/HScfGTNVi+qxSJ9+/HWxEZO7m6q+OGBEBA==
X-Received: by 2002:a63:1417:: with SMTP id u23mr2850482pgl.289.1598257572669;
        Mon, 24 Aug 2020 01:26:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d? ([2601:647:4802:9070:cda6:bf68:c972:645d])
        by smtp.gmail.com with ESMTPSA id h9sm11302035pfq.18.2020.08.24.01.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 01:26:12 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: don't call revalidate_disk from
 nvme_set_queue_dying
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Justin Sanders <justin@coraid.com>,
        linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Stefan Haberland <sth@linux.ibm.com>,
        nbd@other.debian.org
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-4-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b5422c22-7f68-e2a5-ec53-e1457d11f3ad@grimberg.me>
Date:   Mon, 24 Aug 2020 01:26:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
