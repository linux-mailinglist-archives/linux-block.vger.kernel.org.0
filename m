Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF61A43DB
	for <lists+linux-block@lfdr.de>; Fri, 10 Apr 2020 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgDJIpZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Apr 2020 04:45:25 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34469 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJIpZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 04:45:25 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03A8jG2v014259;
        Fri, 10 Apr 2020 10:45:16 +0200
Date:   Fri, 10 Apr 2020 10:45:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/23] floppy: cleanup: do not iterate on current_fdc in
 DMA grab/release functions
Message-ID: <20200410084516.GD14199@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
 <20200331094054.24441-23-w@1wt.eu>
 <f5fb363f-8c2c-3aca-6b71-4a45544d067a@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5fb363f-8c2c-3aca-6b71-4a45544d067a@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 10, 2020 at 11:35:51AM +0300, Denis Efremov wrote:
> I see a couple of similar cycles in do_floppy_init:
> 
> for (i = 0; i < N_FDC; i++) {
>         current_fdc = i;
>         memset(&fdc_state[current_fdc], 0, sizeof(*fdc_state));
>         fdc_state[current_fdc].dtr = -1;
>         fdc_state[current_fdc].dor = 0x4;
> ...
> }
> 
> for (i = 0; i < N_FDC; i++) {
>         current_fdc = i;
>         fdc_state[current_fdc].driver_version = FD_DRIVER_VERSION;
> ...
> }

Ah thanks, I missed these ones! Do you want me to respin this patch ?

Willy
