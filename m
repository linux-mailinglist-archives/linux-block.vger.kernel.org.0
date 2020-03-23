Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA62718F384
	for <lists+linux-block@lfdr.de>; Mon, 23 Mar 2020 12:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgCWLNh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Mar 2020 07:13:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgCWLNh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 07:13:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5E9AAAB98;
        Mon, 23 Mar 2020 11:13:36 +0000 (UTC)
Date:   Mon, 23 Mar 2020 12:13:36 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests v3 2/4] Use _{init,exit}_null_blk instead of
 open-coding these functions
Message-ID: <20200323111336.25cc7xssrf2stkp6@beryllium.lan>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320222413.24386-3-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 20, 2020 at 03:24:11PM -0700, Bart Van Assche wrote:
> This patch reduces code duplication.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
