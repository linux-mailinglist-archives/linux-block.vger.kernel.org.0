Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12D0382DE8
	for <lists+linux-block@lfdr.de>; Mon, 17 May 2021 15:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhEQNwB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 May 2021 09:52:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhEQNwB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 09:52:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621259444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7sasbVGYUEZ5AUFJyqaV2/43qQDZihNx+bYQeU0oug=;
        b=I7bynsVI2NinzMt6jLlxaT7EoTUkMzIIhstMwHywg/jo1hAPH9EXoyrraJJ4DSG2YpY6QI
        bFqeWwhBNI9Rq1Lz1hnEGwT+7cTBLBPJCgWs+IEqtsZF72gl9f1oYwWJgFZBD5AoVCVQ8w
        San4lRm2W38SFSoeeTeHGWizy6gMsAo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23CA6AEB6;
        Mon, 17 May 2021 13:50:44 +0000 (UTC)
Subject: Re: [PATCH 2/8] xen/blkfront: read response from backend only once
To:     Juergen Gross <jgross@suse.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-3-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <8bc3e4e7-a93f-cd8c-3f96-3a8caea38ed3@suse.com>
Date:   Mon, 17 May 2021 15:50:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513100302.22027-3-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.05.2021 12:02, Juergen Gross wrote:
> In order to avoid problems in case the backend is modifying a response
> on the ring page while the frontend has already seen it, just read the
> response into a local buffer in one go and then operate on that buffer
> only.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

