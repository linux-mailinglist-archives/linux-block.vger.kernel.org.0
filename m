Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1314D1510F
	for <lists+linux-block@lfdr.de>; Mon,  6 May 2019 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEFQUu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 May 2019 12:20:50 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:35959 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFQUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 12:20:50 -0400
Received: by mail-it1-f171.google.com with SMTP id o190so3693211itc.1
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BuGEc0vp73+CwK2wSYl6CczFb1TBM5nZdYcbz+gryjc=;
        b=0CcrcuuwYR5OzKH6JXGj6/m3G2KYeHcBAed3WoSESbTKWyuqornMti4ZH+2+UMiz9w
         pj7MUQXrNbOTlVzojPKYqisqLCEedwcM7oC0JyRDYDwP/n0IyBOtiVpcyl5YKvRAZ0St
         WWxkx540B+W0QI14Wfmr5jXaREV66pJeD+p369M3BOIbyQp3Rpa0LpuceAaxgJfiKuD0
         5+H2zH4PRdWy/qdKy9GjoxJQ7PTE1+PFqALzPAIKWHCt8hVnlHXfDxQkwRa/1SqxMm+S
         kCBmKQTmhWwhsbCYyblo4Vtv3ol4q6P/R7ohseyLCsABF77VMWhTYo0zA4q//eClsRcG
         Y4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BuGEc0vp73+CwK2wSYl6CczFb1TBM5nZdYcbz+gryjc=;
        b=KmVW2m8Gjs8+aq0FWFF/6XnL0HTSjsPhSmJt6gZi9Ky22RXMy1s2m9x8m7QpqagZp0
         Y9J6z3LU9v6m3J9kh3N5QQz/rnCNEBy+zV98Y16RM39QJh1rmGAO3xi7k/su2LEeG/Ht
         poTTR9MxKXJF1oWn1P7svbMFy0+97XaNA3aDboNqNyymHcH2XG7c40pSl7NSvgc1Q0aV
         IGXN7InIZtdXFvl1NFP4Ou33pqd45ffH284d/iFJxwjLa6jSD0RVLyEyBr++i9myz29a
         ijfjiOx0Wqxp/TLdh+/vHVPicfCgAGaeWvjprr0V0gwCfsFq+diE4uQatCFnjCv0qvu7
         IG1A==
X-Gm-Message-State: APjAAAXHal7FiFUVRnY4euetv6H5jvFJS/froCGwN0izoFX3YglmzOqK
        dL1aZ0XdRsUHFN5JCkZHK4vFLQ==
X-Google-Smtp-Source: APXvYqxuP5CUFLnijUuK0/cyd6x2CzTcjJSjxfwQOE3eW5rTIEZGVI6gjnUdGx6HRA7ZBcwKZWUoNA==
X-Received: by 2002:a02:52c9:: with SMTP id d192mr19531902jab.53.1557159649143;
        Mon, 06 May 2019 09:20:49 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f1sm1831326ioc.45.2019.05.06.09.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:20:47 -0700 (PDT)
Subject: Re: [GIT PULL 00/26] lightnvm updates for 5.2
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190504183811.18725-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db614650-6edd-9055-c8a1-5303c0447b70@kernel.dk>
Date:   Mon, 6 May 2019 10:20:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/19 12:37 PM, Matias Bjørling wrote:
> Hi Jens,
> 
> Can you please pick up the following patches for the 5.2 window if
> it is too late.

It's very late. Even if I had applied this the second it came in, it
would not even have made linux-next before the merge window opens...
I'll queue this up for later in the merge window merging, but generally
I need to have bigger series a week before final. This generally means
around -rc6 time.

-- 
Jens Axboe

