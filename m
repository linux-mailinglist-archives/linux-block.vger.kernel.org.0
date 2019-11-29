Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84FA10D828
	for <lists+linux-block@lfdr.de>; Fri, 29 Nov 2019 17:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK2QAv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Nov 2019 11:00:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:49952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfK2QAv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 11:00:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DCBFBAF27;
        Fri, 29 Nov 2019 16:00:49 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] xen/xenbus: reference count registered modules
To:     Paul Durrant <pdurrant@amazon.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20191129134306.2738-1-pdurrant@amazon.com>
 <20191129134306.2738-2-pdurrant@amazon.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <599c254c-035b-33a0-9f32-866ffe644ad5@suse.com>
Date:   Fri, 29 Nov 2019 17:00:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191129134306.2738-2-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29.11.2019 14:43, Paul Durrant wrote:
> To prevent a module being removed whilst attached to a frontend, and

Why only frontend?

> hence xenbus calling into potentially invalid text, take a reference on
> the module before calling the probe() method (dropping it if unsuccessful)
> and drop the reference after returning from the remove() method.
> 
> NOTE: This allows the ad-hoc reference counting in xen-netback to be
>       removed. This will be done in a subsequent patch.
> 
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -232,9 +232,11 @@ int xenbus_dev_probe(struct device *_dev)
>  		return err;
>  	}
>  
> +	__module_get(drv->driver.owner);

I guess you really want try_module_get() and deal with it returning
false.

Jan
