Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3216A11C5C6
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2019 07:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfLLGEb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Dec 2019 01:04:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:60748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbfLLGEb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 01:04:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35B59AD75;
        Thu, 12 Dec 2019 06:04:29 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] xen/interface: re-define FRONT/BACK_RING_ATTACH()
To:     Paul Durrant <pdurrant@amazon.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191211152956.5168-1-pdurrant@amazon.com>
 <20191211152956.5168-4-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <cfd8f169-e925-dbff-64b2-d471300a6694@suse.com>
Date:   Thu, 12 Dec 2019 07:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211152956.5168-4-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.12.19 16:29, Paul Durrant wrote:
> Currently these macros are defined to re-initialize a front/back ring
> (respectively) to values read from the shared ring in such a way that any
> requests/responses that are added to the shared ring whilst the front/back
> is detached will be skipped over. This, in general, is not a desirable
> semantic since most frontend implementations will eventually block waiting
> for a response which would either never appear or never be processed.
> 
> Since the macros are currently unused, take this opportunity to re-define
> them to re-initialize a front/back ring using specified values. This also
> allows FRONT/BACK_RING_INIT() to be re-defined in terms of
> FRONT/BACK_RING_ATTACH() using a specified value of 0.
> 
> NOTE: BACK_RING_ATTACH() will be used directly in a subsequent patch.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
