Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30E328527D
	for <lists+linux-block@lfdr.de>; Tue,  6 Oct 2020 21:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgJFTdO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Oct 2020 15:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgJFTdO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 15:33:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A49C061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 12:33:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 650F228A7A9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        kernel@collabora.com, Omar Sandoval <osandov@fb.com>
Subject: Re: [RESEND PATCH v2] block: Consider only dispatched requests for inflight statistic
Organization: Collabora
References: <20201006191509.2482378-1-krisman@collabora.com>
        <20201006192038.2484672-1-krisman@collabora.com>
        <8e53dcca-bd5f-4b81-cf73-d905f2c36dcd@kernel.dk>
Date:   Tue, 06 Oct 2020 15:33:08 -0400
In-Reply-To: <8e53dcca-bd5f-4b81-cf73-d905f2c36dcd@kernel.dk> (Jens Axboe's
        message of "Tue, 6 Oct 2020 13:27:17 -0600")
Message-ID: <874kn7no97.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/6/20 1:20 PM, Gabriel Krisman Bertazi wrote:
>> 
>> Oops, I have no idea what happened, but something ate the hunk at the
>> last submission.  My apologies.  Please find it below.
>
> Care to just resend a fixed up one? Saves me the time from fixing
> things up.

hm, the first submission had an empty patch and the email you quoted had
the entire fixed patch ready to apply with scissors.  It should be good
to apply it, I think.  Or, what do you mean?

-- 
Gabriel Krisman Bertazi
