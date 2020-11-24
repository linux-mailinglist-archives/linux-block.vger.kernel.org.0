Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCDB2C1BF7
	for <lists+linux-block@lfdr.de>; Tue, 24 Nov 2020 04:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKXDXz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Nov 2020 22:23:55 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41406 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKXDXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:23:55 -0500
Received: by mail-pf1-f182.google.com with SMTP id t8so17064052pfg.8
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2020 19:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXkjvDpid20zr1AMjWrezgoJu7BUsnH8wicWuxP+PC0=;
        b=HBiQdb1T3DVoF6hEMv3UFOP0wo+pi5PeUgU/s4CBwkcw+fiiccIVzU/UUmvBtjjNgP
         UCPTXPTW2m0gQJR2hj7blGuPPUx324+JQjBm0P/Qg9RhHpxTzdaZljReEuu0w4q1ndnB
         pqjjIJfrS5FBy8TuaQebgwyhl02WSbrx9HrGdGgzbfKhoE9UqoG4Gq9YLB+nLdnR6ocJ
         XGb4OI1Zz8O4yNXHLttOFvPDuXim+WT9CKWjcWIkmVqXas+MZ8G7c+ezFqHID/P/PId8
         8q8HGehiN4LGed6HdRBYTJowkB7v6qrMEnF5ByxnM3XJIQbIHz5i8dZ2VJMHoPPP1V1X
         Gxrg==
X-Gm-Message-State: AOAM532GFLtmn/ncK55s6056Til+fH5yBkAa2iDVx4Ui9lmh31JVTQKv
        yNRTsS6iQ5JJ6r7KXgtuX2M=
X-Google-Smtp-Source: ABdhPJxzf0jknZnzjNudUmEEQiSvjT+xGaYIFP0Nmrj75T6klNXYVWji/TSaYPIgQmjKcgNuyv2TNg==
X-Received: by 2002:a63:4623:: with SMTP id t35mr2075311pga.270.1606188234495;
        Mon, 23 Nov 2020 19:23:54 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h7sm13290845pgi.90.2020.11.23.19.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 19:23:53 -0800 (PST)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
Date:   Mon, 23 Nov 2020 19:23:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-2-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> -	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
> +	insmod "$(ls /lib/modules/"$(uname -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || return $?

Is 'ls' needed here or is 'echo' sufficient?

Thanks,

Bart.
