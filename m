Return-Path: <linux-block+bounces-299-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8D7F19BC
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2CEB20EB8
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF64208B1;
	Mon, 20 Nov 2023 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09085
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:21:29 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so990158b3a.3
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500889; x=1701105689;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCf9jjTNvwpSJT5BEahXjobWcV7v+Af/RffepxH+UA8=;
        b=VavE6KlDiiSBpewCFQ/8/uqDqpegY7s8E8JFc5d2Usk/P1wAWRPSxsEGb1duyByGsS
         I7I97pM9DyDHUOfKRzSWiISykOCZE0OC4dr9cokMjezstTRHDKSGpElOd8hnpXvbXpRV
         Po45KcJkPrFogJiubugzJ+B6j6Sefo2NQmhcQNwpa1H7ulB2yHk+otAhxuWL4FteQKjp
         O4UFFKQFQ0AihuS2dFf5T53pTWRSoN42lJbNibhReY5NbHaT370kcUPl708HPW9jqK6b
         29+QmHdqqKsSRW7iAzIAxiyOkSnuunudsnwktmDehAicI1Yf2f1H+/JYbhtS/2ET5w6M
         yNig==
X-Gm-Message-State: AOJu0YxI/Rd1Htr4/+NiDky/a106pVyAkSq9/dwnpmDtIArzHv8Gb/8M
	cbUwob6bEgY2XhtylLN+eqNwF6QathA=
X-Google-Smtp-Source: AGHT+IHMcWskXxbSBQ7RsUiIbRXJx8L1ez/0/zdtd2WOl2ChF37WL9UmasA8A2rzBQCXmq8g1samSA==
X-Received: by 2002:a05:6a00:21c5:b0:6be:265:1bf5 with SMTP id t5-20020a056a0021c500b006be02651bf5mr7002374pfj.24.1700500888575;
        Mon, 20 Nov 2023 09:21:28 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:1f10:3e70:e99:93ed? ([2620:0:1000:8411:1f10:3e70:e99:93ed])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a000b5100b006889511ab14sm6354895pfo.37.2023.11.20.09.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:21:28 -0800 (PST)
Message-ID: <481a7f31-2e1d-4999-aeaa-1a0825216ed7@acm.org>
Date: Mon, 20 Nov 2023 09:21:26 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove blk_set_runtime_active()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20231120070611.33951-1-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231120070611.33951-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/23 23:06, Damien Le Moal wrote:
> The function blk_set_runtime_active() is called only from
> blk_post_runtime_resume(), so there is no need for that function to be
> exported. Open-code this function directly in blk_post_runtime_resume()
> and remove it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

