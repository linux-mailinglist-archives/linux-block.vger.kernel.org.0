Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC95164B55
	for <lists+linux-block@lfdr.de>; Wed, 19 Feb 2020 18:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBSRBn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Feb 2020 12:01:43 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:32996 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgBSRBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 12:01:43 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id C99751C46F2;
        Wed, 19 Feb 2020 10:01:42 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at avon.wwwdotorg.org
Subject: Re: dd, close(), sync, and the Linux disk cache
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Simon Glass <sjg@chromium.org>
References: <b7ad1223-4224-da46-4c48-50427360f31c@wwwdotorg.org>
 <20200219163258.GB18377@infradead.org>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <dfff89c0-d3cf-96a0-7f44-4d2256a3aba3@wwwdotorg.org>
Date:   Wed, 19 Feb 2020 10:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219163258.GB18377@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/19/20 9:32 AM, Christoph Hellwig wrote:
> On Wed, Feb 12, 2020 at 05:02:43PM -0700, Stephen Warren wrote:
>> Jens et. al.,
>>
>> If I dd to an SD card (e.g. via a USB SD card reader), is it required to run
>> sync afterward in order to guarantee that all written data is written to the
>> SD card? I'm running dd with a simple command-line like "dd if=file.img
>> of=/dev/sdc".
> 
> Yes.  Or use of=dsync on the dd command line.

Can you explain further why it's necessary given that the kernel 
explicitly blocks execution of close() to flush buffers to disk, 
assuming the process is the last one with the device open? Am I 
misinterpreting the code path I mentioned later in my email? In 
practice, I can see this happening when I use dd.
