Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF6201B87
	for <lists+linux-block@lfdr.de>; Fri, 19 Jun 2020 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbgFSTpF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 Jun 2020 15:45:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:55442 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbgFSTpF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 15:45:05 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6209723B;
        Fri, 19 Jun 2020 19:45:04 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:45:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, krisman@collabora.com, rdunlap@infradead.org
Subject: Re: [PATCH v2] docs: block: Create blk-mq documentation
Message-ID: <20200619134503.60ab689b@lwn.net>
In-Reply-To: <20200605175536.19681-1-andrealmeid@collabora.com>
References: <20200605175536.19681-1-andrealmeid@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri,  5 Jun 2020 14:55:36 -0300
André Almeida <andrealmeid@collabora.com> wrote:

> Create a documentation providing a background and explanation around the
> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
> 
> The reference for writing this documentation was the source code and
> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
> Systems", by Axboe et al.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
> Changes from v1:
> - Fixed typos
> - Reworked blk_mq_hw_ctx

Jens, what's your pleasure on this one?  Should I take it, or do you want
it...?

Thanks,

jon
