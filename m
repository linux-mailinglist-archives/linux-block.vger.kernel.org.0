Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13536A400
	for <lists+linux-block@lfdr.de>; Tue, 16 Jul 2019 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfGPIjK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 Jul 2019 04:39:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfGPIjK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 04:39:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 728233092640;
        Tue, 16 Jul 2019 08:39:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4CBBA60C44;
        Tue, 16 Jul 2019 08:39:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 16 Jul 2019 10:39:10 +0200 (CEST)
Date:   Tue, 16 Jul 2019 10:39:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org
Subject: Re: [PATCH 0/4][v2] rq-qos memory barrier shenanigans
Message-ID: <20190716083907.GC15528@redhat.com>
References: <20190715201120.72749-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715201120.72749-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 16 Jul 2019 08:39:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/15, Josef Bacik wrote:
>
> This is the patch series to address the hang we saw in production because of
> missed wakeups, and the other issues that Oleg noticed while reviewing the code.

You missed another problem. See
https://lore.kernel.org/linux-block/20190711114543.GA14901@redhat.com/

IOW, rq_qos_wait() needs set_current_state(TASK_UNINTERRUPTIBLE) after
io_schedule().

Oleg.

