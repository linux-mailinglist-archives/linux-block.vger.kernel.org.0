Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09930720C9
	for <lists+linux-block@lfdr.de>; Tue, 23 Jul 2019 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfGWUaL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jul 2019 16:30:11 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37216 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbfGWUaL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 16:30:11 -0400
Received: by mail-oi1-f177.google.com with SMTP id t76so33354241oih.4
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 13:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oTBjeYE93tO1P96uKBYgvxtnTpLMPOSORzzCXyGmh7qQ2aWwF3/VER65WoNaof75Wc
         ciHPfgebz/4tSDZ4Bv45qSbfransHBmHqCXSYl3mfmTerjDYV25j5z7ZiBadyMgTBt+Q
         Euq90rxYtDD9qveIhaLl2B0Pg0nuGxSTc1TA4t5FYu7s5N9A79lH1Tx/HBhriwMmyGop
         7aPnjCxSCzC//ne74izFiPbsSIbY2zeIjmeXvT1pj1GhZdKSl7aG6lijy6+FsQ8ORq1q
         WCxO12dKKBcNJBIAIx2HDU3a5VNNfeikbaqzxWdNteQdfWYuTWO0+aeELITtsU9pSUus
         l3/Q==
X-Gm-Message-State: APjAAAUtpvWPx/plNq3oVkIU5re3rxxm4+wl1llbFVxmt6e/eNqHSw/4
        tg+Jr2kOY5H/OeSkr2iFOGs=
X-Google-Smtp-Source: APXvYqxzWe8VivJr5CR6E13uoAJOZHDgTWLgB63g5dYgmt13TMKDyyWmWGXn/CJhuCXRdMnRBId03w==
X-Received: by 2002:aca:6706:: with SMTP id z6mr2780173oix.43.1563913810785;
        Tue, 23 Jul 2019 13:30:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o23sm13907197oie.20.2019.07.23.13.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:30:10 -0700 (PDT)
Subject: Re: [PATCH 5/5] blk-mq: remove blk_mq_complete_request_sync
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-6-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1b92fcc7-fbee-cc87-d9b4-53262cbcd681@grimberg.me>
Date:   Tue, 23 Jul 2019 13:30:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
