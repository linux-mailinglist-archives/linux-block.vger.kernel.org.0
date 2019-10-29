Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10DBE9122
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2019 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfJ2U6H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Oct 2019 16:58:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54922 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfJ2U6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 16:58:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 2157828DE5D
Subject: Re: [PATCH] blk-mq: Document functions for sending request
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com
References: <20191028125537.9047-1-andrealmeid@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <56ca440b-617c-ff63-0e7f-cd606af38ebb@collabora.com>
Date:   Tue, 29 Oct 2019 17:56:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191028125537.9047-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/19 9:55 AM, André Almeida wrote:
> Add or improve documentation for function regarding creating and sending
> IO requests to the hardware.
> 

Just realized I forget to add a function I had documented. A v2 is on
the way, please ignore this v1.
